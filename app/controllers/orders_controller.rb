class OrdersController < ApplicationController
	def index
    if params[:status]
      if params[:status] == "success"
        flash.now[:notice] = "Order successful"
      else
        flash.now[:alert] = "Order failed"
      end
    end

    @orders = current_user.orders

    @past_orders = @orders.select(&:delivered?)
    @current_orders = @orders - @past_orders
	end

	def new
		@order = Order.new

		@order.deliveries << Delivery.new
		@order.order_items = current_user.cart.to_order_items
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
