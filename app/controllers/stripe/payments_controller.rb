class Stripe::PaymentsController < ApplicationController
	def new
		@user = current_user

		@payment_intent = Stripe::PaymentIntent.create({
		  amount: 1099,
		  currency: 'eur',
		  customer: @user.stripe_customer_id
		})
	end
end
