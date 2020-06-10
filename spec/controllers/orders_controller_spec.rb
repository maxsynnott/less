require "rails_helper"

RSpec.describe OrdersController, "#index" do
	before { sign_in create(:user, orders_count: 2) }

	it "assigns orders and renders index" do
		get :index

		orders = assigns(:orders)
		expect(orders.length).to eq 2
		orders.each { |order| expect(order).to be_instance_of Order }

		expect(response).to render_template :index
	end
end
