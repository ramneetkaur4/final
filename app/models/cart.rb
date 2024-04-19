class Cart < ApplicationRecord
  # has_many :cart_items, dependent: :destroy
  validates :user, presence: true
end
