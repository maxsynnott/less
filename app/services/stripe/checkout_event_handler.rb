module Stripe
	class CheckoutEventHandler < EventHandler
		def handle_checkout_session_completed(event)
      object = event.data.object

			billing = Billing.find_by_session_id(object.id)
			billing.update(status: 'success')

      user = billing.user

      cart = user.cart

      orders = cart.create_orders(billing)
      cart.clear

      # Replace these decisions with logic
      next_available_datetime = DateTime.now.next_week.change(hour: 14) # Next monday at 14:00

      delivery = Delivery.create(
        user_id: user.id,
        price: 0.00, # Currently free
        delivered: false,
        address_id: user.address.id,
        scheduled_at: next_available_datetime
      )

      orders.each { |order| order.update(delivery_id: delivery.id) }
		end
	end
end
