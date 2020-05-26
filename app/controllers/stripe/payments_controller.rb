class Stripe::PaymentsController < ApplicationController
	def new
		@intent = Stripe::PaymentIntent.create({
		  amount: 1099,
		  currency: 'eur'
		})

		p @intent
	end
end
