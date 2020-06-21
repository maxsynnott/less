require "rails_helper"

RSpec.describe CartsController, "#edit" do
	before { sign_in create(:user) }
	let(:cart) { controller.current_user.cart }

	it "correctly assigns cart and renders :edit" do
		get :edit, params: { id: cart.id }

		expect(assigns(:cart)).to eq cart

		expect(response).to render_template :edit
	end
end
