class CartsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:edit, :update]

	def edit
		@cart = Cart.find(params[:id])
	end

	def update
		# Need to include error handling logic

		@cart = Cart.find(params[:id])
		@cart.update(cart_params)
	end

	private

	def cart_params
		params.require(:cart).permit(cart_items_attributes: [:id, :_destroy, :quantity])
	end
end
