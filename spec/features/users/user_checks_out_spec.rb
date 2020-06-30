require 'rails_helper'
require 'stripe_mock'

include Features::StripeHelper

RSpec.feature "User checks out", ngrok: true do
	before do
		Stripe::WebhookEndpoint.update(
		  ENV["STRIPE_RSPEC_WEBHOOK_ID"],
		  { url: "#{Capybara.app_host}/stripe/webhook" },
		)

		@user = create(:user)

		login_as @user, scope: :user
	end

	context "they have a full cart" do
		before { @user.cart.add_item(create(:item, name: "Flour", price: 2), 500) }

		context "they enter valid details", js: true do
			context "they have payment methods" do
				before do
					StripeMock.start

					payload = double(data: double(empty?: false, map: [["**** **** **** 4242", "pm_123"]]))

					allow(Stripe::PaymentMethod).to receive(:list).and_return(payload)
				end

				after { StripeMock.stop }

				context "they use an authenticated card" do
					scenario "the order is created and they are redirected to the show page" do
						visit new_order_path

						fill_in "Delivery address", with: "Rudi Dutschke str. 26"
						fill_in "Phone number", with: "+494242424242"
						fill_in "Delivery instructions", with: "Knock thrice"
						find("label.custom-control.custom-radio", match: :first).click()
						find("span#select2-order_payment_method_id-container").click()
						find("li.select2-results__option", text: "**** **** **** 4242").click()

						find("button[data-target='checkout.submitButton']:enabled").click()

						expect(page).to have_content "Your order has been confirmed and will be delivered on"
					end
				end
			end
		end
	end

	context "test" do
		scenario "testing", js: true do
			visit new_order_path

			fill_in "Delivery address", with: "Rudi Dutschke str. 26"
			fill_in "Phone number", with: "+494242424242"
			fill_in "Delivery instructions", with: "Knock thrice"
			find("label.custom-control.custom-radio", match: :first).click()
			click_on "Add Payment Method"

			fill_stripe_elements

			click_on "Save card"

			sleep(10)
		end
	end
end