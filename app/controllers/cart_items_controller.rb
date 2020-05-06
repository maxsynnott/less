class CartItemsController < ApplicationController
  def create
  	cart_item = CartItem.new(cart_item_params)

    @product = cart_item.product
    cart = current_user.cart
  	
  	cart_item.cart_id = cart.id

    # Rework this
    if cart.find_cart_item(@product)
      cart.add_product(@product, cart_item.quantity)
    else
      cart_item.save
    end
  end

  def update
    cart_item = CartItem.find(params[:id])

    cart_item.update(cart_item_params)

    redirect_to cart_path(id: cart_item.cart.id)
  end

  def destroy
    cart_item = CartItem.find(params[:id])

    cart_item.destroy

    redirect_to cart_path(id: cart_item.cart.id)
  end

  private

  def cart_item_params
  	params.require(:cart_item).permit(:product_id, :quantity)
  end
end
