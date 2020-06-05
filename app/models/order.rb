class Order < ApplicationRecord
	belongs_to :user

	has_many :deliveries, inverse_of: :order
	has_many :order_items, inverse_of: :order

	accepts_nested_attributes_for :deliveries, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

	def check_out(container)
		ContainerOrder.create(
			container_id: container.id,
			order_id: id
		)
	end

	def total
		order_items.sum(&:total)
	end
end
