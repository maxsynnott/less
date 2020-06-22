class DeliveriesController < ApplicationController
	def index
		@unaccepted_deliveries = Delivery.unaccepted
		@driver_deliveries = Delivery.where(driver_id: current_user.id)
	end

	def show
		@delivery = Delivery.find(params[:id])
	end

	def update
		@delivery = Delivery.find(params[:id])

		if @delivery.update(delivery_params)
			redirect_to deliveries_path
		end
	end

	def tracker
		@delivery = Delivery.find(params[:delivery_id])

		@initial_markers = [
			{
				lat: @delivery.latitude,
				lng: @delivery.longitude
			},
			{
				lat: 52.537154,
				lng: 13.394585,
				image_url: helpers.asset_url("delivery_driver_icon.png")
			}
		]
	end

	private

	def delivery_params
		params.require(:delivery).permit(:driver_id)
	end
end
