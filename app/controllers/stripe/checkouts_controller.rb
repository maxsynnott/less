class Stripe::CheckoutsController < ApplicationController
	def new
		cart = current_user.cart

		line_items = cart.line_items

		session = Stripe::Checkout::Session.create(
			shipping_address_collection: {
		    allowed_countries: ['DE'],
		  },
		  payment_method_types: ['card'],
		  line_items: line_items,
		  success_url: success_stripe_checkouts_url,
		  cancel_url: cart_url(cart),
		  metadata: cart.to_metadata
		)

		Billing.create(
			user_id: cart.user.id,
			status: 'pending',
			amount: line_items.sum { |item| item[:amount] }.to_money, # Done this way to ensure identical to charged amount
			session_id: session.id,
			metadata: cart.to_metadata.to_json
		)

		render json: { session_id: session.id }
	end

	def success
		# Insert successful checkout logic here

		redirect_to orders_path		
	end
end
