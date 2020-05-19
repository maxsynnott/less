require 'rails_helper'

RSpec.feature "User logs in and attempts to visit admin urls" do
	scenario "the user is not granted access and is instead redirected to admin sign in" do
		create(:user, email: "user@example.com", password: "123456")

		visit new_user_session_path

		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "123456"

		click_on "sign-in-button"

		visit admin_root_path

		expect(page).to have_selector ".flash", text: "You need to sign in or sign up before continuing."

		visit admin_products_path

		expect(page).to have_selector ".flash", text: "You need to sign in or sign up before continuing."
	end
end