require 'rails_helper'

RSpec.describe "Admin logs in" do
	scenario "they see the admin dashboard" do
		create(:user, email: "admin@example.com", password: "password", role: "admin")

		visit admin_root_path

		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"

		find("input[value='Log in']").click

		expect(page).to have_selector ".flash", text: "Signed in successfully"
		expect(page).to have_content "Dashboard"
	end
end