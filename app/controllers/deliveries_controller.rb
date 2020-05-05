class DeliveriesController < ApplicationController
	def index
		@deliveries = current_user.deliveries
	end

	def edit
		@delivery = Delivery.find(params[:id])
	end

	def update
		@delivery = Delivery.find(params[:id])

		@delivery.update(delivery_params)

		redirect_to deliveries_path
	end

	private

	def delivery_params
		params.require(:delivery).permit(:scheduled_at, :address_id)
	end
end
