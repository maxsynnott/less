class Container < ApplicationRecord
	before_create :generate_unique_key

	validates_presence_of :size

	def checked_out?
		container_orders.any?(&:checked_out?)
	end

	def returned?
		!checked_out?
	end

	def return
		container_orders.where(returned_at: nil).update_all(returned_at: DateTime.now)
	end

	private

	def generate_unique_key
		self.unique_key = SecureRandom.urlsafe_base64(nil, false)[0..5]
		generate_unique_key if Container.exists?(unique_key: self.unique_key)
	end
end
