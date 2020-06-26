class OrdersController < ApplicationController
	def index
    @orders = current_user.orders.reject(&:delivered?)
	end

	def new
		@order = Order.new
    @user = current_user

		@order.delivery = Delivery.new
		@order.order_items = @user.cart.to_order_items

    @grouped_time_slots = TimeSlot.available.group_by(&:date)

    assign_payment_methods
	end

	def create
    @user = current_user

    @order = Order.new(order_params)
    @order.user = @user

    @order.delivery = Delivery.new unless @order.delivery

    if @order.save
      payment_intent = @order.create_payment_intent(
        payment_method: @order.payment_method_id,
        off_session: false,
        confirm: true,
        return_url: order_url(@order)
      )

      @order.update(payment_intent_id: payment_intent.id)

      case payment_intent.status
      when 'succeeded'
        @order.confirm

        redirect_to order_path(@order)
      when 'requires_action'
        redirect_to stripe_payment_intents_confirm_path(id: @order.payment_intent_id)
      end
    else
      assign_payment_methods
      @grouped_time_slots = TimeSlot.available.group_by(&:date)

      render :new
    end
  end

  def show
  	@order = Order.find(params[:id])

    assign_milestones if @order.milestone

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
