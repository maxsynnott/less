class DeliveriesController < ApplicationController
	def update
		@delivery = Delivery.find(params[:id])

		@delivery.update(delivery_params)

		redirect_to orders_path
	end

	def tracker
		@delivery = Delivery.find(params[:delivery_id])
	end

	private

	def delivery_params
		params.require(:delivery).permit(:scheduled_at)
	end
end
