require "rails_helper"

RSpec.describe CartItemsController, "#create" do
	before { sign_in create(:user) }
	let(:product) { create(:product) }

	context "JS" do
		context "when provided with valid params" do
			let(:valid_params) { { cart_item: { product_id: product.id, quantity: 500 } } }

			it "creates the cart_item and renders :create" do
				expect(CartItem.count).to eq 0

				post :create, xhr: true, params: valid_params

				expect(CartItem.count).to eq 1
				expect(CartItem.first).to have_attributes(
					product_id: product.id,
					quantity: 500
				)

				expect(response).to render_template(:create)
			end
		end

		context "when provided with invalid params" do
			let(:valid_params) { { cart_item: { product_id: product.id, quantity: -500 } } }

			it "does not create the cart_item" do
				expect(CartItem.count).to eq 0

				post :create, xhr: true, params: valid_params

				expect(CartItem.count).to eq 0

				expect(response).to render_template(:create)
			end
		end
	end
end