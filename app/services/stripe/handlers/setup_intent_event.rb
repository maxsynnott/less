module Stripe
  module Handlers
  	class SetupIntentEvent < Stripe::Handlers::Event
  		def handle_setup_intent_succeeded(event)
  			object = event.data.object

        user = User.find(object.metadata.user_id)

        payment_method = Stripe::PaymentMethod.retrieve(
          object.payment_method
        )
        
        PaymentMethodsChannel.broadcast_to user, payment_method
  		end
  	end
  end
end
