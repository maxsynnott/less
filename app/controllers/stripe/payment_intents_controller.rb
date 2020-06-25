class Stripe::PaymentIntentsController < ApplicationController
	def confirm
		@order = Order.find_by_payment_intent_id(params[:id])

		@payment_intent = Stripe::PaymentIntent.retrieve(
			params[:id]
		)
	end
end
