require 'rails_helper'

RSpec.feature "User updates their account details" do
	before { login_as create(:user, email: "user_128@example.com", password: "123456", phone: nil), scope: :user }

	scenario "the user successfully updates their details" do
		visit edit_user_registration_path

		expect(find_field("user[email]").value).to eq "user_128@example.com"
		fill_in "Phone", with: "+4912345678900"
		fill_in "Current password", with: "123456"

		click_on "Update"

		click_on "Account"

		expect(find_field("user[email]").value).to eq "user_128@example.com"
		expect(find_field("user[phone]").value).to eq "+4912345678900"
	end
end