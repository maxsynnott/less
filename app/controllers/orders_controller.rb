class OrdersController < ApplicationController
	def index
    @orders = current_user.orders.reject(&:delivered?)
	end

	def new
		@order = Order.new
    @user = current_user

		@order.delivery = Delivery.new
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

  def track
    @order = Order.find(params[:id])
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

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:quantity, :item_id], delivery_attributes: [:scheduled_at, :address, :phone, :instructions])
  end

  def assign_milestones
    assign_current_milestone

    @milestones = [
      { icon: "check", text: "Confirmed" },
      { icon: "truck-loading", text: "Packed" },
      { icon: "truck", text: "On the way" },
      { icon: "home", text: "Delivered" }
    ]

    @milestones.map!.with_index do |milestone, i|
      if i <= @current_milestone
        milestone.merge(active: true)
      else
        milestone
      end
    end

    @current_percentage = 16.5 + (33 * @current_milestone)
  end

  def assign_current_milestone
    @current_milestone = 3
  end
end
