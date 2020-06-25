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

  def receipt
    @order = Order.find(params[:id])

    render pdf: "file_name", template: "orders/receipt.html.erb", layout: 'pdf.html'
  end

  def add_to_cart
    @order = Order.find(params[:id])

    @order.add_to_cart(current_user.cart)
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

  # Rough temp code
  def assign_current_milestone
    # Milstones:
    # 0: Confirmed
    # 1: Packed
    # 2: On the way
    # 3: Delivered

    if @order.confirmed?
      @current_milestone = 0

      if @order.packed?
        @current_milestone = 1

        if @order.on_the_way?
          @current_milestone = 2

          if @order.delivered?
            @current_milestone = 3
          end
        end
      end
    end
  end
end
