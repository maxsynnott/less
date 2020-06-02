class Shop < ApplicationRecord
  belongs_to :address

  has_many :products
  has_many :users
end
