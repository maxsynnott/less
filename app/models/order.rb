class Order < ApplicationRecord
	belongs_to :delivery
	belongs_to :product
	belongs_to :billing

	validates_presence_of :product, :quantity, :price, :billing
end
