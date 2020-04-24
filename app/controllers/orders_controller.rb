class OrdersController < ApplicationController
  def create
  	order = Order.new(order_params)
  	
  	order.cart_id = current_user.cart.id

  	order.save

  	redirect_to products_path
  end

  def update

  end

  def destroy

  end

  private

  def order_params
  	params.require(:order).permit(:product_id, :quantity)
  end
end
