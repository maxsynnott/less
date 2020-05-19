class Product < ApplicationRecord
	include PgSearch::Model

	pg_search_scope :search,
	against: {
		name: 'A',
		description: 'B'
	},
	using: {
		tsearch: { 
			prefix: true,
			dictionary: "english"
		},
		trigram: {
			only: [:name]
		}
	}

	acts_as_taggable_on :tags

	has_one_attached :image

	has_many :recipe_items
	has_many :cart_items
	has_many :orders
	has_many :stocks, dependent: :destroy

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
