class CartItemsController < ApplicationController
  # Error handling is difficult for this guy, needs a rework
  def create
    cart = current_user.cart

  	@cart_item = CartItem.new(cart_item_params)

    @product = @cart_item.product

    cart.add_product(@product, @cart_item.quantity)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
