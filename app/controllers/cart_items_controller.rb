class CartItemsController < ApplicationController
  def create
    cart = current_user.cart

  	@cart_item = CartItem.new(cart_item_params)

    @product = @cart_item.product

    cart.add_product(@product, @cart_item.quantity)
  end

  def update
    @cart_item = CartItem.find(params[:id])

    if @cart_item.update(cart_item_params)
      redirect_to cart_path
    else
      @errors = @cart_item.errors
      p @errors
      render "carts/show"
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])

    @cart_item.destroy

    redirect_to cart_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
