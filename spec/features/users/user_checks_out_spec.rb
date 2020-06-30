require 'rails_helper'

include Features::StripeHelper

RSpec.feature "User checks out", js: true do
	before do
		@user = create(:user)

		login_as @user, scope: :user
	end

	context "they have a full cart" do
		before { @user.cart.add_item(create(:item, name: "Flour", price: 2), 500) }

		context "they enter valid details" do
			context "they have payment methods" do
				context "they use an authenticated card" do
					
				end
			end

			context "they have no payment methods" do
				context "they add a card" do
					context "the card doesn't require authentication" do
						
					end
				end
			end
		end
	end

	context "they have payment methods" do
		before do
			Stripe::PaymentMethod.attach(
			  'pm_card_visa',
			  { customer: @user.stripe_customer_id },
			)
		end

		context "they enter valid details" do
			context	"their card requires authentication" do

			end

			context	"their card doesn't require authentication" do
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

		context "they enter invalid details" do

		end
	end

	context "they don't have payment methods" do
		context "they add a card requiring authentication" do
			context "they complete authentication" do
				scenario "the order is created and they are redirected to the show page" do
					visit new_order_path

					fill_in "Delivery address", with: "Rudi Dutschke str. 26"
					fill_in "Phone number", with: "+494242424242"
					fill_in "Delivery instructions", with: "Knock thrice"
					find("label.custom-control.custom-radio", match: :first).click

					fill_stripe_elements(number: "4000002760003184")

					click_on "Add card"

					expect(page).to have_css "span.select2-selection__rendered", text: "**** **** **** 3184"

					find("button[data-target='checkout.submitButton']:enabled").click()

					complete_authentication

					expect(page).to have_content "Your order has been confirmed and will be delivered on", wait: 30
				end
			end

			context "they fail authentication" do

			end
		end

		context "they add a card not requiring authentication" do
			scenario "the order is created and they are redirected to the show page" do
				visit new_order_path

				fill_in "Delivery address", with: "Rudi Dutschke str. 26"
				fill_in "Phone number", with: "+494242424242"
				fill_in "Delivery instructions", with: "Knock thrice"
				find("label.custom-control.custom-radio", match: :first).click()

				fill_stripe_elements(number: "4242424242424242")

				click_on "Add card"

				expect(page).to have_css "span.select2-selection__rendered", text: "**** **** **** 4242", wait: 30

				find("button[data-target='checkout.submitButton']:enabled").click()

				expect(page).to have_content "Your order has been confirmed and will be delivered on"
			end
		end
	end
end