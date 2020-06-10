require 'rails_helper'

# Needs to be reworked
# RSpec.feature "Admin masquerades as a user" do
# 	before { login_as create(:admin_user), scope: :admin_user }
# 	let(:user) { create(:user, email: "user_64@example.com") }

# 	scenario "admin is masqueraded as the user and still has access to the admin dashboard" do
# 		visit admin_user_path(id: user.id)

# 		click_on "Masquerade"

# 		expect(current_url).to eq root_url

# 		find('.fa-user').find(:xpath, "..").click

# 		expect(find_field("user[email]").value).to eq "user_64@example.com"

# 		visit admin_root_path

# 		expect(page).to have_text "Welcome to Active Admin"
# 	end
# end
