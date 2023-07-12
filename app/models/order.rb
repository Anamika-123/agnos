class Order < ApplicationRecord
  STATUSES = [:cart, :completed]

  enum status: STATUSES

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :order_promotions, dependent: :destroy

  before_save :set_final_amount

  after_commit :send_order_notification, on: :update, if: -> { status_previously_changed?(from: "cart", to: "completed") }

  private

  def set_final_amount
    self.final_amount = item_total + tax_amount - promotional_amount
  end

  def send_order_notification
    OrderNotificationJob.perform_later(self)
  end
end
