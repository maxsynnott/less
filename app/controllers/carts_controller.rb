class CartsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:edit, :update]

	def edit
		@cart = Cart.find(params[:id])
	end
end
