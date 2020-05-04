class BillingsController < ApplicationController
	def create
		@cart = Cart.find(params[:cart_id])

		Billing.create(user_id: @cart.user.id, status: 'pending', amount: @cart.cents_total)

		@session = Stripe::Checkout::Session.create(
		  payment_method_types: ['card'],
		  line_items: @cart.line_items,
		  success_url: 'http://localhost:3000', # NEED TO INCLUDE CHECKOUT SESSION ID STUFF HERE
		  cancel_url: 'http://localhost:3000',
		)
	end
end