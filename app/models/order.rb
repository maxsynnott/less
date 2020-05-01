class Order < ApplicationRecord
	belongs_to :product
	belongs_to :user

	validates_presence_of :product, :user, :quantity, :price
end
