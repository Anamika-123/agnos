class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :price, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  after_initialize :set_price, if: :product

  before_save :set_tax

  private

  def set_price
    self.price = product.price
  end

  def set_tax
    tax_percentage = product.tax_percentage

    self.tax = quantity * price * tax_percentage / 100
  end
end