module Stripe
	class CheckoutEventHandler < EventHandler
		def handle_checkout_session_completed(event)
			session_id = event.data.object.id

			billing = Billing.find_by_session_id(session_id)

			billing.update(status: 'success')
		end
	end
end
