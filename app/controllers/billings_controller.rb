class BillingsController < ApplicationController
	def create
		@cart = Cart.find(params[:cart_id])

		line_items = @cart.line_items

		@session = Stripe::Checkout::Session.create(
			shipping_address_collection: {
		    allowed_countries: ['DE'],
		  },
		  payment_method_types: ['card'],
		  line_items: line_items,
		  success_url: orders_url,
		  cancel_url: cart_url(@cart),
		)

		Billing.create(
			user_id: @cart.user.id,
			status: 'pending',
			amount: line_items.sum { |item| item[:amount] }.to_money, # Done this way to ensure identical to charged amount
			session_id: @session.id
		)
	end
end