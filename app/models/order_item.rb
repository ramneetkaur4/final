class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_save :update_order_total

  before_save :calculate_cart_item_amount

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "product_id", "quantity", "updated_at"]
  end

  def update_order_total
    order = Order.find_by(id: self.order_id)
    order.total_amount = order.order_items.sum(:total_amount)
    order.save!
  end

  def calculate_cart_item_amount
    self.total_amount = quantity.to_f * amount.to_f
  end
end
