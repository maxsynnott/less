class Product < ApplicationRecord
	$tags = [
		"gluten-free",
		"vegetarian",
		"vegan",
		"dairy-free",
		"organic"
	]

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

	belongs_to :store

	has_many :cart_items

	validates_presence_of :name, :price

	def price_for(amount)
		price * amount
	end
end
