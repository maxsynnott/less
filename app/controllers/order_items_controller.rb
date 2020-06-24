class OrderItemsController < ApplicationController
	def add_to_cart
	  @order_item = OrderItem.find(params[:id])

	  @order_item.add_to_cart(current_user.cart)
	end
end

