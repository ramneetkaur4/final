class Cart < ApplicationRecord
<<<<<<< HEAD
  # has_many :cart_items, dependent: :destroy
=======
  has_many :cart_items, dependent: :destroy
  
>>>>>>> caa98c6955c5a0cf6d53c23c38690f9f8bb26de3
  validates :user, presence: true
end
