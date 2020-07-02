class Api::V1::OrdersController < Api::V1::BaseController
  def show
    @order = Order.find(params[:id])
  end

  def breakdown
    @order = Order.new(order_params)

    render :breakdown, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:payment_method_id, order_items_attributes: [:price, :quantity, :unit_id], delivery_attributes: [:scheduled_at, :address, :phone, :instructions])
  end

  def render_error
    render json: { errors: @order.errors.messages }, status: :unprocessable_entity
  end
end
