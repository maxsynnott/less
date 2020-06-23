class Api::V1::UsersController < Api::V1::BaseController
	def update_driver_coordinates
		@user = User.find(params[:id])

		@user.deliveries.each do |delivery|
			delivery.update(driver_longitude: params[:longitude].to_i, driver_latitude: params[:latitude].to_i)
		end

		render json: { status: :ok }
	end

	private

	def driver_params
	  params.require(:user).permit(:first_name)
	end

	def render_error
	  render json: { errors: @order.errors.messages }, status: :unprocessable_entity
	end
end