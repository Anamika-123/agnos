class PromotionService
  attr_reader :promotion

  def initialize(promotion)
    @promotion = promotion
  end

  def apply_on(order)
    if promotion.eligible_on?(order)
      order.order_promotions.create!(
        promotion: promotion,
        discount: promotion.discount
      )
    end
  end
end
