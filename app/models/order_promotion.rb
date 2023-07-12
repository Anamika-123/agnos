class OrderPromotion < ApplicationRecord
  belongs_to :order
  belongs_to :promotion

  before_create :set_discount

  private

  def set_discount
    self.discount = if promotion.flat?
      promotion.discount
    elsif promotion.percentage?
      order.item_total * promotion.discount / 100
    end
  end
end