require 'rails_helper'

RSpec.feature "Guest signs up" do
	context "with a full cart" do
		scenario "they create an account with a full cart" do
			visit new_user_registration_path

			cart = Cart.last

			cart.add_unit(create(:unit), 100)

			fill_in "First name", with: "Max"
			fill_in "Email", with: "max@example.com"
			fill_in "Password", with: "123456"
			fill_in "Password confirmation", with: "123456"

			click_on "Sign up"

			expect(page).to have_content "Welcome! You have signed up successfully."
			expect(page).to have_link "Account"

			expect(find("#cart_count").text).to eq "1"
		end
	end

	context "without an empty cart" do
		context "they enter valid details" do
			scenario "they create an account with an empty cart" do
				visit new_user_registration_path

				fill_in "First name", with: "Max"
				fill_in "Email", with: "max@example.com"
				fill_in "Password", with: "123456"
				fill_in "Password confirmation", with: "123456"

				click_on "Sign up"

				expect(page).to have_content "Welcome! You have signed up successfully."
				expect(page).to have_link "Account"

				expect(find("#cart_count").text).to eq "0"
			end
		end

		context "they enter invalid details" do
			scenario "they are shown the appropriate error messages" do
				visit new_user_registration_path

				fill_in "First name", with: "Max"
				fill_in "Email", with: "@example.com"
				fill_in "Password", with: "123456"
				fill_in "Password confirmation", with: "123456"

				click_on "Sign up"

				expect(page).to have_content "Email is invalid"
			end
		end

		context "they enter an incorrect password confirmation" do
			scenario "they are shown the appropriate error messages" do
				visit new_user_registration_path

				fill_in "First name", with: "Max"
				fill_in "Email", with: "max@example.com"
				fill_in "Password", with: "123456"
				fill_in "Password confirmation", with: "1234567"

				click_on "Sign up"

				expect(page).to have_content "Password confirmation doesn't match"
			end
		end
	end
end