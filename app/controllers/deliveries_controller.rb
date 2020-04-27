class DeliveriesController < ApplicationController
	def index
		@deliveries = current_user.deliveries
	end

	def new
		@delivery = Delivery.new(user_id: current_user.id)
	end

	def create
		@delivery = Delivery.new(delivery_params.merge(user_id: current_user.id))

		@delivery.save

		redirect_to deliveries_path
	end

	private

	def delivery_params
		params.require(:delivery).permit(:scheduled_at, :address_id)
	end
end
