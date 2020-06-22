require 'rails_helper'

RSpec.describe "Admin logs in" do
	scenario "they see the admin dashboard" do
		create(:user, email: "admin@example.com", password: "password", role: "admin")

		visit admin_root_path

		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"

		# save_and_open_page

		click_on "log_in_button"

		expect(page).to have_selector ".flash", text: "Signed in successfully"
		expect(page).to have_content "Dashboard"
	end
end