class AddressesController < ApplicationController
	def index
		@addresses = Address.where(user_id: current_user.id)
	end

	def new
		@address = Address.new(country: "DE", city: "Berlin", state: "Berlin")
	end

	def create
		@address = Address.new(address_params.merge(country: "DE", city: "Berlin", state: "Berlin"))

		@address.user_id = current_user.id

		@address.save

		redirect_to addresses_path
	end

	private

	def address_params
		params.require(:address).permit(:recipient, :street, :house_number, :city, :postal_code, :state, :country)
	end
end
