class OrdersController < ApplicationController
  def create
  	order = Order.new(order_params)
  	
  	order.cart_id = current_user.cart.id

  	order.save

  	redirect_to products_path
  end

  def update
    order = Order.find(params[:id])

    order.update(order_params)

    redirect_to cart_path(id: order.cart.id)
  end

  def destroy
    order = Order.find(params[:id])

    order.destroy

    redirect_to cart_path(id: order.cart.id)
  end

  private

  def order_params
  	params.require(:order).permit(:product_id, :quantity)
  end
end
