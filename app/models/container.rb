class Container < ApplicationRecord
	validates_presence_of :size

	def cents_price
		(price * 100).ceil
	end
end
