class OrdersController < ApplicationController
	def index
    @orders = current_user.orders.reject(&:delivered?)
	end

	def new
		@order = Order.new
    @user = current_user

		@order.delivery = Delivery.new
		@order.order_items = @user.cart.to_order_items

    @grouped_datetimes = Delivery.available_datetimes.group_by(&:to_date)

    assign_payment_methods
	end

	def create
    @user = current_user

    @order = Order.new(order_params)
    @order.user = @user

    @order.delivery = Delivery.new unless @order.delivery

    if @order.save
      redirect_to order_path(@order)
    else
      assign_payment_methods
      @grouped_datetimes = Delivery.available_datetimes.group_by(&:to_date)

      p "ERRORS"
      p @order.errors
      render :new
    end
  end

  def show
  	@order = Order.find(params[:id])

    assign_milestones

    # For tracker

    @delivery = @order.delivery

    @initial_markers = [
      {
        lat: @delivery.latitude,
        lng: @delivery.longitude
      },
      {
        lat: @delivery.driver_latitude,
        lng: @delivery.driver_longitude,
        image_url: helpers.asset_url("delivery_driver_icon.png")
      }
    ]
  end

  def receipt
    @order = Order.find(params[:id])

    render pdf: "file_name", template: "orders/receipt.html.erb", layout: 'pdf.html'
  end

  def add_to_cart
    @order = Order.find(params[:id])

    @order.add_to_cart(current_user.cart)
  end

  private

  def assign_payment_methods
    @payment_methods = Stripe::PaymentMethod.list(
      customer: @user.stripe_customer_id,
      type: 'card'
    ).data.map { |pm| ["**** " * 3 + pm.card.last4, pm.id] }
  end

  def order_params
    params.require(:order).permit(:payment_method_id, order_items_attributes: [:quantity, :item_id], delivery_attributes: [:scheduled_at, :address, :phone, :instructions])
  end

  def assign_milestones
    @milestones = [
      { icon: "check", text: "Confirmed" },
      { icon: "truck-loading", text: "Packed" },
      { icon: "truck", text: "On the way" },
      { icon: "home", text: "Delivered" }
    ]

    @milestones.map!.with_index do |milestone, i|
      if i <= @order.milestone
        milestone.merge(active: true)
      else
        milestone
      end
    end

    @current_percentage = 16.5 + (33 * @order.milestone)
  end
end
