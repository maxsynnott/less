require 'rails_helper'

RSpec.describe "Admin logs in" do
	scenario "they see the admin dashboard" do
		create(:admin_user, email: "admin@example.com", password: "password")

		visit admin_root_path

		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"

		click_on "Login"

		expect(page).to have_selector ".flash", text: "Signed in successfully"
		expect(page).to have_content "Dashboard"
	end
end