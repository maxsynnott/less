class Api::V1::CartItemsController < Api::V1::BaseController
  def update
    @cart_item = CartItem.find(params[:id])

    @cart_item.update(cart_item_params)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])

    @cart_item.destroy
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  def render_error
    render json: { errors: @cart_item.errors.messages }, status: :unprocessable_entity
  end
end
