class AddressesController < ApplicationController
	def index
		@addresses = current_user.addresses
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

	def edit
		@address = Address.find(params[:id])
	end

	def update
		@address = Address.find(params[:id])

		@address.update(address_params)

		redirect_to addresses_path
	end

	def destroy
		@address = Address.find(params[:id])

		@address.destroy

		redirect_to addresses_path
	end

	private

	def address_params
		params.require(:address).permit(:recipient, :street, :house_number, :city, :postal_code, :state, :country, :notes)
	end
end
