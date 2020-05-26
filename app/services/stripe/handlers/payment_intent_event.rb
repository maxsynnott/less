module Stripe
  module Handlers
  	class PaymentIntentEvent < Stripe::Handlers::Event
  		def handle_payment_intent_succeeded(event)
        puts 'Recieved successful payment intent'

        # Put success logic here
  		end
  	end
  end
end
