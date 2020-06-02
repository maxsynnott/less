class Order < ApplicationRecord
	belongs_to :delivery
	belongs_to :user

	validates_presence_of :quantity, :price

	def check_out(container)
		ContainerOrder.create(
			container_id: container.id,
			order_id: id
		)
	end
end
