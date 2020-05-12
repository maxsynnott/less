class CartsController < ApplicationController
	def edit
		@cart = Cart.find(params[:id])
	end

	def update
		@cart = Cart.find(params[:id])

		if @cart.update(cart_params)
			redirect_to edit_cart_path(id: @cart.id)
		else
			render :edit
		end
	end

	private

	def cart_params
		params.require(:cart).permit(cart_items_attributes: [:id, :_destroy, :quantity])
	end
end
