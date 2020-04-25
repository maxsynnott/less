class Product < ApplicationRecord
	include PgSearch::Model
	
	pg_search_scope :search, against: {
		name: 'A',
		description: 'B'
	}

	has_many :orders

	def price_for(amount)
		price * amount
	end

	def cents_price_for(amount)
		(price_for(amount) * 100).ceil
	end
end
