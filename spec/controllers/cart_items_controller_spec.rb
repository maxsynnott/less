require "rails_helper"

RSpec.describe CartItemsController, "#destroy" do
	before { sign_in create(:user, :with_cart_item) }
	let(:cart_item) { controller.current_user.cart_items.first }

	it "destroys the cart_item and redirects to cart_path" do
		expect(CartItem.count).to eq 1

		delete :destroy, params: { id: cart_item.id }

		expect(CartItem.count).to eq 0

		expect(response).to redirect_to cart_path
	end
end