require "rails_helper"

RSpec.describe CartsController, "#edit" do
	before { sign_in create(:user) }
	let(:cart) { controller.current_user.cart }

	it "correctly assigns cart and renders :edit" do
		get :edit, params: { id: cart.id }

		expect(assigns(:cart)).to eq cart

		expect(response).to render_template(:edit)
	end
end

RSpec.describe CartsController, "#update" do
	before { sign_in create(:user, :with_cart_item) }
	let(:cart) { controller.current_user.cart }
	let(:cart_item) { cart.cart_items.first }

	context "when provided with nested params" do
		context "when they are valid" do
			context "when updating quantity" do
				let(:valid_params) { { id: cart.id, cart: { cart_items_attributes: [{ id: cart_item.id, quantity: 500 }] } } }

				it "assigns cart, updates relations and redirects to edit_cart_path" do
					patch :update, params: valid_params

					cart.reload
					cart_item.reload

					expect(assigns(:cart)).to eq cart
					expect(cart.cart_items).to eq [cart_item]
					expect(cart_item.quantity).to eq 500

					expect(response).to redirect_to edit_cart_path(id: cart.id)
				end
			end

			context "when destroying relations" do
				let(:valid_params) { { id: cart.id, cart: { cart_items_attributes: [{ id: cart_item.id, _destroy: true }] } } }

				it "assigns cart, removes/destroys associations and redirects to edit_cart_path" do
					expect(CartItem.count).to eq 1

					patch :update, params: valid_params

					cart.reload

					expect(assigns(:cart)).to eq cart
					expect(cart.cart_items).to be_empty

					expect(CartItem.count).to eq 0

					expect(response).to redirect_to edit_cart_path(id: cart.id)
				end
			end
		end

		context "when they are invalid" do
			let(:invalid_params) { { id: cart.id, cart: { cart_items_attributes: [{ id: cart_item.id, quantity: -500 }] } } }

			it "assigns cart and errors and renders :edit" do
				patch :update, params: invalid_params

				cart.reload
				cart_item.reload

				expect(assigns(:cart)).to eq cart
				expect(cart.cart_items).to eq [cart_item]
				expect(cart_item.quantity).to eq 1000

				expect(assigns(:cart).cart_items.first.errors).to_not be_empty

				expect(response).to render_template(:edit)
			end
		end
	end
end
