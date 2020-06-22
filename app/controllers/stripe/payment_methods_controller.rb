class Stripe::PaymentMethodsController < ApplicationController
	def new
		@setup_intent = Stripe::SetupIntent.create(
			customer: current_user.stripe_customer_id,
			usage: "on_session",
			metadata: {
				user_id: current_user.id
			}
		)
	end
end
