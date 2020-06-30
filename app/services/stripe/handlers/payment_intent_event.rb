module Stripe
  module Handlers
  	class PaymentIntentEvent < Stripe::Handlers::Event
  		def handle_payment_intent_succeeded(event)
  			payment_intent = event.data.object

        order = ::Order.find_by_payment_intent_id(payment_intent.id)

        # OrderMailer.with(order: order).new_order_email.deliver_later

        # # Untested
        # if object.metadata[:adjustment]
        #   order.user.adjust_balance(object.metadata[:adjustment].to_i)
        # end

        order.confirm unless order.confirmed?
  		end
  	end
  end
end
