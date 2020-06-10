class Api::V1::Stripe::SetupIntentsController < Api::V1::BaseController
	def create
		@setup_intent = Stripe::SetupIntent.create(
			customer: current_user.stripe_customer_id,
			usage: "on_session"
		)

		render :show, status: :created
	end
end