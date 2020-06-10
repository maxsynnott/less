class Store < ApplicationRecord
	has_one_attached :image

	has_many :store_items
  has_many :items, through: :store_items
  has_many :users
end
