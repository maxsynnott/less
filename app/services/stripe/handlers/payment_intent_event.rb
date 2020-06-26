module Stripe
  module Handlers
  	class PaymentIntentEvent < Stripe::Handlers::Event
  		def handle_payment_intent_succeeded(event)
  			object = event.data.object

        order_id = object.metadata.order_id.to_i

        order = ::Order.find(order_id)

        # OrderMailer.with(order: order).new_order_email.deliver_later

        # # Untested
        # if object.metadata[:adjustment]
        #   order.user.adjust_balance(object.metadata[:adjustment].to_i)
        # end

        order.confirm

        OrderRefreshChannel.broadcast_to order, { refresh: true }
  		end
  	end
  end
end
