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

	private

	def delivery_params
		params.require(:delivery).permit(:driver_id, :scheduled_at)
	end
end
