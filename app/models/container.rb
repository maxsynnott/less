class Container < ApplicationRecord
	before_create :generate_unique_key

	validates_presence_of :size

	def cents_price
		(price * 100).ceil
	end

	private

	def generate_unique_key
		self.unique_key = SecureRandom.urlsafe_base64(nil, false)[0..5]
		generate_unique_key if Container.exists?(unique_key: self.unique_key)
	end
end
