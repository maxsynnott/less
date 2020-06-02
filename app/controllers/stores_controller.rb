class StoresController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index, :show]

	def index
		@stores = Store.all	
	end

	def show
		@store = Store.find(params[:id])
	end
end
