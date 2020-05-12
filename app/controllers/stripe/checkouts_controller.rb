class Stripe::CheckoutsController < ApplicationController
	def new
		cart = current_user.cart

		if cart.empty?
			response = { error: "Cannot checkout with an empty cart" }
		else
			session = Stripe::Checkout::Session.create(
				shipping_address_collection: {
			    allowed_countries: ['DE'],
			  },
			  payment_method_types: ['card'],
			  line_items: cart.line_items,
			  success_url: success_stripe_checkouts_url,
			  cancel_url: edit_cart_url(id: cart.id),
			  metadata: cart.to_metadata
			)

			response = { session_id: session.id }
		end

		render json: response
	end

	def success
		# Insert successful checkout logic here

		redirect_to orders_path		
	end
end
