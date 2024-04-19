class Address < ApplicationRecord
  belongs_to :user
  validates :street, :city, :postal_code, :country, presence: true
  validates :postal_code, format: { with: /\A\d{5}\z/, message: "should be in the format XXXXX" }
end
