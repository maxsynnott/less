class Stripe::CheckoutsController < ApplicationController
	def new
		cart = current_user.cart

		session = Stripe::Checkout::Session.create(
			shipping_address_collection: {
		    allowed_countries: ['DE'],
		  },
		  payment_method_types: ['card'],
		  line_items: cart.line_items,
		  success_url: success_stripe_checkouts_url,
		  cancel_url: cart_url,
		  metadata: cart.to_metadata
		)

		render json: { session_id: session.id }
	end

	def success
		# Insert successful checkout logic here

		redirect_to orders_path		
	end
end
