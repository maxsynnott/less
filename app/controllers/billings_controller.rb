class BillingsController < ApplicationController
	def create
		@cart = Cart.find(params[:cart_id])

		@session = Stripe::Checkout::Session.create(
			shipping_address_collection: {
		    allowed_countries: ['DE'],
		  },
		  payment_method_types: ['card'],
		  line_items: @cart.line_items,
		  success_url: deliveries_url, # NEED TO INCLUDE CHECKOUT SESSION ID STUFF HERE
		  cancel_url: cart_url(@cart),
		)

		Billing.create(
			user_id: @cart.user.id,
			status: 'pending',
			amount: @cart.cents_total,
			session_id: @session.id
		)
	end
end