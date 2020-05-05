module Stripe
	class CheckoutEventHandler < EventHandler
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

			billing = Billing.find_by_session_id(object.id)
			billing.update(status: 'success', address_id: address.id)

      user = billing.user

      cart = user.cart

      orders = cart.create_orders(billing)
      cart.clear

      delivery = Delivery.create(
        user_id: user.id,
        price: 0.00, # Currently free
        delivered: false,
        address_id: address.id,
        scheduled_at: Delivery.next_available_datetime
      )

      orders.each { |order| order.update(delivery_id: delivery.id) }
		end
	end
end
