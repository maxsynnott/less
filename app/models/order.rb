class Order < ApplicationRecord
	belongs_to :delivery, optional: true
	belongs_to :product
	belongs_to :billing

	has_many :stock_transactions
	has_many :container_orders
	has_many :containers, through: :container_orders

	validates_presence_of :product, :quantity, :price, :billing

	after_create :withdraw_stock

	def check_out(container)
		ContainerOrder.create(
			container_id: container.id,
			order_id: id
		)
	end

	private

	def withdraw_stock
		remaining = quantity

		# Need to handle negative stock logic
		until remaining.zero? or product.stock.zero?
			stock = product.positive_stocks.first

			if stock
				amount = [remaining, stock.balance].min
				stock.withdraw(amount, self)

				remaining -= amount
			end
		end
	end
end
