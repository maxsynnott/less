class Order < ApplicationRecord
	belongs_to :delivery
	belongs_to :product
	belongs_to :billing
	belongs_to :user

	validates_presence_of :product, :user, :quantity, :price, :billing
end
