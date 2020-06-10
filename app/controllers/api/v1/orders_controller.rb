class Api::V1::OrdersController < Api::V1::BaseController
  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:price, :quantity, :item_id], deliveries_attributes: [:scheduled_at, :address, :phone, :instructions])
  end

  def render_error
    render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
  end
end
