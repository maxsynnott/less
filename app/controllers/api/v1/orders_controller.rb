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

  def check_validity
    @order = Order.new(order_params)
    @order.user = current_user

    @order.deliveries << Delivery.new if @order.deliveries.empty?

    @order.valid?

    render :check_validity, status: :ok
  end

  def pay
    @order = Order.find(params[:id])

    unless @order.paid?
      @payment_intent = @order.create_payment_intent(
        payment_method: @order.payment_method_id,
        confirm: true
      )

      render :pay, status: :ok
    end    
  end

  private

  def order_params
    params.require(:order).permit(:payment_method_id, order_items_attributes: [:price, :quantity, :item_id], deliveries_attributes: [:scheduled_at, :address, :phone, :instructions])
  end

  def render_error
    render json: { errors: @order.errors.messages }, status: :unprocessable_entity
  end
end
