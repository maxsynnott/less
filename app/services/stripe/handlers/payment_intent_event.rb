module Stripe
  module Handlers
  	class PaymentIntentEvent < Stripe::Handlers::Event
  		def handle_payment_intent_succeeded(event)
  			object = event.data.object

        order_id = object.metadata.order_id.to_i

        order = ::Order.find(order_id)

        # Untested
        if object.metadata[:adjustment]
          order.user.update(balance: order.user.balance + object.metadata[:adjustment].to_i)
        end

        order.update(paid: true)
  		end
  	end
  end
end
