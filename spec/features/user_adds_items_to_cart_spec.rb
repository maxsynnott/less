require 'rails_helper'

RSpec.feature "User adds items to cart" do
	before { login_as create(:user, email: "user_128@example.com", password: "123456"), scope: :user }

	scenario "the items are added to cart" do
		visit items_path

		# save_and_open_page
	end
end
