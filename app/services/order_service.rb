class OrderService
  attr_reader :order, :errors

  def initialize(order)
    @order = order
  end

  def add_item(product_id)    
    order_item = order.order_items.find_by(product_id: product_id)

    if order_item
      update_item(order_item.id, order_item.quantity + 1)
    else
      create_item(product_id)
    end
  end

  def create_item(product_id)
    @errors = []
    item = order.order_items.build(product_id: product_id)

    Order.transaction do
      if item.save
        refresh_order_totals
      else
        errors.concat(item.errors.full_messages)
      end
    end

    item
  end

  def update_item(item_id, quantity)
    @errors = []
    item = order.order_items.find(item_id)

    Order.transaction do
      if item.update(quantity: quantity)
        refresh_order_totals
      else
        errors.concat(item.errors.full_messages)
      end
    end

    item
  end

  def delete_item(item_id)
    @errors = []
    item = order.order_items.find(item_id)

    OrderItem.transaction do
      item.destroy
      refresh_order_totals
    end

    item
  end

  private

  def refresh_order_totals
    recalculate_item_total
    reapply_promotion
    recalculate_final_total
    order.save!
  end

  def reapply_promotion
    order.order_promotions.destroy_all

    Promotion.system.each do |promotion|
      PromotionService.new(promotion).apply_on(order)
    end
  end

  def recalculate_item_total
    order.item_total = order.order_items.sum('price * quantity')
  end

  def recalculate_final_total
    order.promotional_amount = order.order_promotions.sum(:discount)
    order.tax_amount = order.order_items.sum(:tax)
  end
end