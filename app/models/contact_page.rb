class ContactPage < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at"]
  end
end
