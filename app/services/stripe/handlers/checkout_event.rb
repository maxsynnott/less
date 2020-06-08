module Stripe
  module Handlers
    # Not completely sure why but full module path
    # CheckoutEvent < Event inherits from Stripe::Event when running server however not in console
  	class CheckoutEvent < Stripe::Handlers::Event
  		def handle_checkout_session_completed(event)
        object = event.data.object

        shipping = object.shipping

        address = Address.create(
          recipient: shipping.name,
          line_1: shipping.address.line1,
          line_2: shipping.address.line2,
          postal_code: shipping.address.postal_code,
          city: shipping.address.city,
          state: shipping.address.state,
          country: shipping.address.country
        )

        delivery = Delivery.create(
          price: 0.00, # Currently free
          delivered: false,
          address_id: address.id,
          scheduled_at: Delivery.available_dts.sample
        )

        metadata = object.metadata

        billing = Billing.create(
          user_id: metadata.user_id,
          status: "success",
          amount: metadata.total,
          session_id: object.id,
          metadata: metadata
        )

        user = billing.user

        user.update(stripe_customer_id: object.customer) if object.customer

        orders = billing.create_orders
        orders.each { |order| order.update(delivery_id: delivery.id) }

        user.cart.clear
  		end
  	end
  end
end
