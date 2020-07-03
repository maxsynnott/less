require 'rails_helper'

include Features::StripeHelper

RSpec.feature "User checks out", js: true do
	before do
		@user = create(:user)

		login_as @user, scope: :user
	end

	context "they have payment methods" do
		before do
			["pm_card_authenticationRequired", "pm_card_visa"]
			.each { |pm| Stripe::PaymentMethod.attach(pm, customer: @user.stripe_customer_id) }
		end

		context "they enter valid details" do
			context	"their card requires authentication" do
				context "they complete_authentication" do
					scenario "they are redirected to the order show page", ngrok: true do
						visit new_order_path

						fill_in "Delivery address", with: "Rudi Dutschke str. 26"
						fill_in "Phone number", with: "+494242424242"
						click_on "Add delivery instructions"
						fill_in "Delivery instructions", with: "Knock thrice"
						find("label.custom-control.custom-radio", match: :first).click
						find("span#select2-order_payment_method_id-container").click
						find("li.select2-results__option", text: "**** **** **** 3184").click

						find("button[data-target='checkout.submitButton']:enabled").click

						complete_authentication

						expect(page).to have_content "Your order has been confirmed and will be delivered on", wait: 30

						expect(current_path).to end_with order_path(id: Order.last.id)
					end
				end
			end

			context	"their card doesn't require authentication" do
				scenario "they are redirected to the order show page" do
					visit new_order_path

					fill_in "Delivery address", with: "Rudi Dutschke str. 26"
					fill_in "Phone number", with: "+494242424242"
					click_on "Add delivery instructions"
					fill_in "Delivery instructions", with: "Knock thrice"
					find("label.custom-control.custom-radio", match: :first).click
					find("span#select2-order_payment_method_id-container").click
					find("li.select2-results__option", text: "**** **** **** 4242").click

					find("button[data-target='checkout.submitButton']:enabled").click

					expect(page).to have_content "Your order has been confirmed and will be delivered on"

					expect(current_path).to end_with order_path(id: Order.last.id)
				end
			end
		end

		context "they enter invalid details" do
			scenario "they are shown error messages" do
				visit new_order_path

				expect(page).to have_css "button[data-target='checkout.submitButton']:disabled"

				fill_in "Phone number", with: "123"

				expect(page).to have_css "button[data-target='checkout.submitButton']:disabled"

				fill_in "Delivery address", with: "Rudi Dutschke str. 26"

				expect(page).to have_css "button[data-target='checkout.submitButton']:disabled"

				find("span#select2-order_payment_method_id-container").click
				find("li.select2-results__option", text: "**** **** **** 4242").click

				expect(page).to have_css "button[data-target='checkout.submitButton']:disabled"

				find("label.custom-control.custom-radio", match: :first).click

				find("button[data-target='checkout.submitButton']:enabled").click

				expect(page).to have_css ".invalid-feedback", text: "Phone is invalid"

				expect(page).to have_css "button[data-target='checkout.submitButton']:disabled"
			end
		end
	end

	context "they don't have payment methods" do
		context "they add a card requiring authentication" do
			context "they complete authentication" do
				scenario "they are redirected to the order show page", ngrok: true do
					visit new_order_path

					fill_in "Delivery address", with: "Rudi Dutschke str. 26"
					fill_in "Phone number", with: "+494242424242"
					click_on "Add delivery instructions"
					fill_in "Delivery instructions", with: "Knock thrice"
					find("label.custom-control.custom-radio", match: :first).click

					fill_stripe_elements(number: "4000002760003184")

					click_on "Add card"

					expect(page).to have_css "span.select2-selection__rendered", text: "**** **** **** 3184"

					find("button[data-target='checkout.submitButton']:enabled").click

					complete_authentication

					expect(page).to have_content "Your order has been confirmed and will be delivered on", wait: 30

					expect(current_path).to end_with order_path(id: Order.last.id)
				end
			end

			context "they fail authentication" do
				scenario "they are shown an error message" do
					visit new_order_path

					fill_in "Delivery address", with: "Rudi Dutschke str. 26"
					fill_in "Phone number", with: "+494242424242"
					click_on "Add delivery instructions"
					fill_in "Delivery instructions", with: "Knock thrice"
					find("label.custom-control.custom-radio", match: :first).click

					fill_stripe_elements(number: "4000002760003184")

					click_on "Add card"

					expect(page).to have_css "span.select2-selection__rendered", text: "**** **** **** 3184"

					find("button[data-target='checkout.submitButton']:enabled").click

					fail_authentication

					expect(page).to have_css ".alert-danger", text: "We are unable to authenticate your payment method. Please choose a different payment method and try again.", wait: 10

					expect(current_path).to end_with new_order_path
				end
			end
		end

		context "they add a card not requiring authentication" do
			scenario "they are redirected to the order show page" do
				visit new_order_path

				fill_in "Delivery address", with: "Rudi Dutschke str. 26"
				fill_in "Phone number", with: "+494242424242"
				click_on "Add delivery instructions"
				fill_in "Delivery instructions", with: "Knock thrice"
				find("label.custom-control.custom-radio", match: :first).click

				fill_stripe_elements(number: "4242424242424242")

				click_on "Add card"

				expect(page).to have_css "span.select2-selection__rendered", text: "**** **** **** 4242", wait: 30

				find("button[data-target='checkout.submitButton']:enabled").click

				expect(page).to have_content "Your order has been confirmed and will be delivered on"

				expect(current_path).to end_with order_path(id: Order.last.id)
			end
		end
	end
end