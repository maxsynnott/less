class CartsController < ApplicationController
	def checkout
		@cart = Cart.find(params[:id])

		items = @cart.orders.map do |order| 
			{ 
				name: order.product.name,
			  description: order.product.description,
			  amount: order.product.price,
			  currency: 'eur',
			  quantity: order.quantity 
			} 
		end

		Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

		@session = Stripe::Checkout::Session.create(
		  payment_method_types: ['card'],
		  line_items: items,
		  success_url: 'http://localhost:3000', # NEED TO INCLUDE CHECKOUT SESSION ID STUFF HERE
		  cancel_url: 'http://localhost:3000',
		)
	end

	def show
		@cart = Cart.find(params[:id])
	end
end
