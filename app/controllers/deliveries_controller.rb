class DeliveriesController < ApplicationController
	def update
		@delivery = Delivery.find(params[:id])

		@delivery.update(delivery_params)

		redirect_to orders_path
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
		params.require(:delivery).permit(:scheduled_at)
	end
end
