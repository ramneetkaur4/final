class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # validates :content, presence: true, length: { maximum: 1000 }

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "product_id", "updated_at", "user_id"]
  end
end
