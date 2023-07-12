class Promotion < ApplicationRecord
  DISCOUNT_TYPES = ['flat', 'percentage']
  enum discount_type: DISCOUNT_TYPES

  validates :type, :discount_type, :discount, presence: true

  scope :active, -> { where(active: true) }
  scope :system, -> { active.where(system: true) }

  before_save :set_rule

  def eligible_on?(order)
    order.instance_eval(rule)
  end
end
