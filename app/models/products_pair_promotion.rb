class ProductsPairPromotion < Promotion
  attr_accessor :product_id, :discounted_product_id

  validates :product_id, :discounted_product_id, presence: true

  def set_rule
    self.rule = <<~RULE
      order_items.where(product_id: [#{product_id}, #{discounted_product_id}]).count == 2
    RULE
  end
end
