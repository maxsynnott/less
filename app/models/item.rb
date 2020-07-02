class Item < ApplicationRecord
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

	has_one_attached :main_image
	has_many_attached :images

	has_many :stocks
	has_many :units

	validates_presence_of :name, :price

	def base_unit
		units.find(&:base?)
	end

	def price_for(amount)
		price * amount
	end

	def stock
		stocks.sum(&:balance)
	end

	def image_count
		images.count + (main_image.attached? ? 1 : 0)
	end
end
