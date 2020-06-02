class ShopsController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
		@shops = Shop.all	
	end

	def show
		@shop = Shop.find(params[:id])
	end
end