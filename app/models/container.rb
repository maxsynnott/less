class Container < ApplicationRecord
	belongs_to :order_item, optional: true

	delegate :order, to: :order_item, allow_nil: true
	delegate :user, to: :order, allow_nil: true

	before_create :generate_unique_key

	validates_presence_of :size

	def return
		if user.update(balance: user.balance + price)
			update(order_item_id: nil)
		end
	end

	def available?
		!order_item_id
	end

	private

	def generate_unique_key
		self.unique_key = SecureRandom.urlsafe_base64(nil, false)[0..5]
		generate_unique_key if Container.exists?(unique_key: self.unique_key)
	end
end
