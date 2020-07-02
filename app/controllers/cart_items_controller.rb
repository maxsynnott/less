class CartItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  # This needs to be fixed to not create double up units
  def create
  	@cart_item = CartItem.new(cart_item_params)
    @cart_item.cart = current_cart

    current_cart.add_cart_item(@cart_item)

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
    params.require(:cart_item).permit(:quantity, :unit_id)
  end
end
