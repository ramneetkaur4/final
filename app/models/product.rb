class Product < ApplicationRecord
  belongs_to :category
  has_many :orders, through: :order_items
  has_many :reviews
  has_one_attached :image
  has_many :cart_items
  has_and_belongs_to_many :categories

  validates :name, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "order_items_id", "reviews_id", "cart_items_id", "created_at", "description", "id", "name", "price", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category", "image_attachment", "image_blob", "order_items", "reviews", "cart_items"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category"] # Only include the "category" association
  end
end
