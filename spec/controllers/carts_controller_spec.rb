require "rails_helper"

RSpec.describe CartsController, "#show" do
	before { sign_in create(:user) }

	it "assigns cart and renders :show" do
		get :show

		expect(assigns(:cart)).to be_instance_of Cart

		expect(response).to render_template(:show)
	end
end
