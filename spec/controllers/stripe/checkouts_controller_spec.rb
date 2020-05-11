require 'rails_helper'

RSpec.describe Stripe::CheckoutsController, "#new" do
	before { StripeMock.start }
  after { StripeMock.stop }

	before { sign_in(@user = create(:user)) }

	context "when user's cart is full" do
		before { @user.cart.cart_items << create(:cart_item) }

		it "renders a JSON with a session id" do
			get :new

			parsed_response = JSON.parse(response.body)

			# stripe-ruby-mock returns the session_id: "test_cs_1"
			# However in reality stripe seems to generate ids in format "cs_test_...."
			# The following regex: /(cs_|test_){2}\w+/ should match either format
			expect(parsed_response["session_id"]).to match /(cs_|test_){2}\w+/
		end
	end

	context "when user's cart is empty" do
		it "renders a JSON with an error message" do
			get :new

			parsed_response = JSON.parse(response.body)

			expect(parsed_response["error"]).to eq "Cannot checkout with an empty cart"
		end
	end
end
