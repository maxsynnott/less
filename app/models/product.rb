class Product < ApplicationRecord
	has_many :orders

	def price_for(amount)
		price * amount
	end

	def cents_price_for(amount)
		(price_for(amount) * 100).ceil
	end
end
