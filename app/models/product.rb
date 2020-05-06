class Product < ApplicationRecord
	include PgSearch::Model
	
	pg_search_scope :search, against: {
		name: 'A',
		description: 'B'
	}

	has_many :recipe_items
	has_many :cart_items
	has_many :orders

	validates_presence_of :name, :price

	def price_for(amount)
		price * amount
	end

	def cents_price_for(amount)
		(price_for(amount) * 100).ceil
	end
end
