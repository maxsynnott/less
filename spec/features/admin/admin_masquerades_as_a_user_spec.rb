require 'rails_helper'

RSpec.feature "Admin masquerades as a user" do
	before do
		login_as create(:admin_user)
	end

	let(:user) { create(:user, email: "user_64@example.com") }

	scenario "admin is masqueraded as the user and still has access to the admin dashboard" do
		visit admin_user_path(id: user.id)

		click_on "Masquerade"

		expect(current_url).to eq root_url

		click_on "Account"

		expect(find_field("user[email]").value).to eq "user_64@example.com"

		visit admin_root_path

		expect(page).to have_text "Welcome to Active Admin"
	end
end
