class CartItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  # Error handling is difficult for this guy, needs a rework
  def create
  	@cart_item = CartItem.new(cart_item_params)

    @item = @cart_item.item

    current_cart.add_item(@item, @cart_item.quantity)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
