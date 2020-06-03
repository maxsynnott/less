class OrdersController < ApplicationController
	def index
		@orders = current_user.orders
	end

	def new
		@order = Order.new
		@delivery = Delivery.new
		@order.deliveries << @delivery
	end

	def create
		@order = Order.new(order_params)
		@order.user_id = current_user.id

		if @order.save
			redirect_to root_path
		else
			p @order.errors
			render :new
		end
	end

	private

	def order_params
		params.require(:order).permit(deliveries_attributes: [:scheduled_at, :address, :phone, :instructions])
	end
end
