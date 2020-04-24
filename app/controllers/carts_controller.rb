class CartsController < ApplicationController
	def checkout
		@cart = Cart.find(params[:id])

		@session = Stripe::Checkout::Session.create(
		  payment_method_types: ['card'],
		  line_items: @cart.line_items,
		  success_url: 'http://localhost:3000', # NEED TO INCLUDE CHECKOUT SESSION ID STUFF HERE
		  cancel_url: 'http://localhost:3000',
		)
	end

	def show
		@cart = Cart.find(params[:id])
	end
end
