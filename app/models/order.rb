class Order < ApplicationRecord
	belongs_to :user

	has_many :deliveries, inverse_of: :order

	accepts_nested_attributes_for :deliveries, reject_if: :all_blank, allow_destroy: true

	def check_out(container)
		ContainerOrder.create(
			container_id: container.id,
			order_id: id
		)
	end
end
