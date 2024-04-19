class AboutPage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at"]
  end
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
end
