class Order < ApplicationRecord
	belongs_to :delivery
	belongs_to :product
	belongs_to :billing

	has_many :container_orders

	validates_presence_of :product, :quantity, :price, :billing

	def check_out(container)
		ContainerOrder.create(
			container_id: container.id,
			order_id: id
		)
	end
end
