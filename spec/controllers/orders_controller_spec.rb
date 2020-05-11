require "rails_helper"

RSpec.describe OrdersController, "#index" do
	before { sign_in create(:user, orders_count: 2) }

	it "should assign products and render index" do
		get :index

		expect(assigns(:orders).map(&:class)).to eq [Order, Order]

		expect(response).to render_template(:index)
	end
end