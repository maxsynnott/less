class Store < ApplicationRecord
	has_one_attached :image

  has_many :items
  has_many :users
end
