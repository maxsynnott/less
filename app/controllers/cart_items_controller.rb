class CartItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  # This is dumb, change this
  def create
  	@cart_item = CartItem.new(cart_item_params)

    current_cart.add_item(@cart_item.item, @cart_item.quantity)

    respond_to do |format|
      format.html do
        flash.notice = "#{@cart_item.item.name} added to cart"

        redirect_to items_path
      end

      format.js
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
