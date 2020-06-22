class OrdersController < ApplicationController
	def index
    @orders = current_user.orders.reject(&:delivered?)
	end

	def new
		@order = Order.new
    @user = current_user

		@order.deliveries << Delivery.new
		@order.order_items = @user.cart.to_order_items

    @payment_method_collection = Stripe::PaymentMethod.list(
      customer: @user.stripe_customer_id,
      type: 'card'
    ).data
	end

	def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
  	@order = Order.find(params[:id])

  	unless @order.paid
      @user = current_user

  		@payment_intent = @user.create_payment_intent(
        amount: @order.total.to_cents,
        metadata: {
          order_id: @order.id
        }
      )

      @payment_methods = Stripe::PaymentMethod.list(
        customer: @user.stripe_customer_id,
        type: 'card'
      ).data
  	end
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:quantity, :item_id], deliveries_attributes: [:scheduled_at, :address, :phone, :instructions])
  end
end
