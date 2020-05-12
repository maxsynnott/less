require "rails_helper"

RSpec.describe CartItemsController, "#destroy" do
	before { sign_in create(:user, :with_cart_item) }
	let(:cart_item) { controller.current_user.cart_items.first }

	it "destroys the cart_item and redirects to cart_path" do
		delete :destroy, params: { id: cart_item.id }

		expect(assigns(:cart_item)).to eq cart_item
		expect(assigns(:cart_item)).to be_destroyed

		expect(response).to redirect_to cart_path
	end
end