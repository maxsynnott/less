class Product < ApplicationRecord
	include PgSearch::Model
	
	pg_search_scope :search, against: {
		name: 'A',
		description: 'B'
	}

	has_one_attached :image

	has_many :recipe_items
	has_many :cart_items
	has_many :orders
	has_many :stocks

	validates_presence_of :name, :price

	def price_for(amount)
		price * amount
	end

	def stock
		stocks.sum(&:balance)
	end

	def positive_stocks
		stocks.select { |stock| stock.balance.positive? }
	end
end
