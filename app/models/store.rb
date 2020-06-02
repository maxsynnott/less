class Store < ApplicationRecord
	has_one_attached :image
	
  belongs_to :address

  has_many :products
  has_many :users
end
