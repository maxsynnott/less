class OrdersController < ApplicationController
	def index
		@orders = current_user.orders
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
  		@intent = Stripe::PaymentIntent.create({
  		  amount: @order.total.to_cents,
  		  currency: 'eur',
  		  customer: current_user.stripe_customer_id,
  		  metadata: { order_id: @order.id }
  		})
  	end
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:quantity, :product_id], deliveries_attributes: [:scheduled_at, :address, :phone, :instructions])
  end
end
