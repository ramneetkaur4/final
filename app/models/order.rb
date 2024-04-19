class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum payment_method: { cash_on_delivery: 0, online_payment: 1 }
  enum status: { order_created: 0, order_delivered: 1, order_cancelled: 2 }

  # validates :user_id, presence: true
  # validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  def self.ransackable_associations(auth_object = nil)
    ["order_items", "products", "user"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "gst", "hst", "id", "payment_method", "pst", "status", "total_amount", "updated_at", "user_id"]
  end
  def calculate_taxes
    case user.province
    when 'Ontario'
      self.pst = nil
      self.gst = total_amount * 0.05
      self.hst = total_amount * 0.13
      self.total_amount += gst + hst
    when 'Alberta', 'Northwest Territories', 'Nunavut', 'Yukon'
      self.gst = total_amount * 0.05
      self.pst = nil
      self.hst = nil
      self.total_amount += gst
    when 'British Columbia'
      self.gst = total_amount * 0.05
      self.pst = total_amount * 0.07
      self.hst = nil
      self.total_amount += gst + pst
    when 'Manitoba'
      self.gst = total_amount * 0.05
      self.pst = total_amount * 0.07
      self.hst = nil
      self.total_amount += gst + pst
    when 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Prince Edward Island'
      self.gst = nil
      self.pst = nil
      self.hst = total_amount * 0.15
      self.total_amount += hst
    when 'Quebec'
      self.gst = total_amount * 0.05
      self.pst = nil
      self.hst = total_amount * 0.09975
      self.total_amount += gst + hst
    when 'Saskatchewan'
      self.gst = total_amount * 0.05
      self.pst = total_amount * 0.06
      self.hst = nil
      self.total_amount += gst + pst
    else
      self.gst = nil
      self.pst = nil
      self.hst = nil
    end
  end

  def find_taxes
    case user.province
    when 'Ontario'
      self.pst = nil
      self.gst = total_amount * 0.05
      self.hst = total_amount * 0.13
      return gst + hst
    when 'Alberta', 'Northwest Territories', 'Nunavut', 'Yukon'
      self.gst = total_amount * 0.05
      self.pst = nil
      self.hst = nil
      return gst + hst
    when 'British Columbia'
      self.gst = total_amount * 0.05
      self.pst = total_amount * 0.07
      self.hst = nil
      return gst + hst
    when 'Manitoba'
      self.gst = total_amount * 0.05
      self.pst = total_amount * 0.07
      self.hst = nil
      return gst + hst
    when 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Prince Edward Island'
      self.gst = nil
      self.pst = nil
      self.hst = total_amount * 0.15
      return gst + hst
    when 'Quebec'
      self.gst = total_amount * 0.05
      self.pst = nil
      self.hst = total_amount * 0.09975
      self.total_amount += gst + hst
    when 'Saskatchewan'
      self.gst = total_amount * 0.05
      self.pst = total_amount * 0.06
      self.hst = nil
      return gst + hst
    else
      self.gst = nil
      self.pst = nil
      self.hst = nil

      return 0
    end
  end
end
