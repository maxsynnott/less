require 'rails_helper'

RSpec.feature "Admin creates an admin_user" do
	before { login_as create(:admin_user) }

	scenario "they see the created admin_user" do
		visit admin_admin_users_path

		click_on "New Admin User"

		fill_in "Email", with: "new_admin@example.com"
		fill_in "admin_user_password", with: "123456"
		fill_in "admin_user_password_confirmation", with: "123456"

		click_on "Create Admin user"

		expect(page).to have_selector ".flash", text: "Admin user was successfully created."
		expect(page).to have_text "new_admin@example.com"
	end
end
