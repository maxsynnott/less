class Api::V1::DeliveriesController < Api::V1::BaseController
	def update
		@delivery = Delivery.find(params[:id])

		if @delivery.update(delivery_params)
			render json: { broadcasted: true }, status: :ok
		else
			render_error
		end
	end

	private

	def delivery_params
	  params.require(:delivery).permit(:driver_latitude, :driver_longitude)
	end

	def render_error
	  render json: { errors: @delivery.errors.messages }, status: :unprocessable_entity
	end
end