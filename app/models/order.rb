class Order < ApplicationRecord
	belongs_to :delivery, optional: true
	belongs_to :product
	belongs_to :billing

	has_many :stock_transactions
	has_many :container_orders
	has_many :containers, through: :container_orders

	validates_presence_of :product, :quantity, :price, :billing

	def check_out(container)
		ContainerOrder.create(
			container_id: container.id,
			order_id: id
		)
	end
end
