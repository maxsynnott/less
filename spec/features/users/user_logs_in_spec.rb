require 'rails_helper'

RSpec.feature "User logs in" do
	before do
		@user = create(:user, email: "user@example.com", password: "123456")
	end

	context "user has added items to their guest cart" do
		scenario "the user is logged in and the cart is persisted" do
			visit new_user_session_path

			@cart = Cart.last

			@cart.add_item(create(:item, name: "Flour"), 1000)
			@cart.add_item(create(:item, name: "Rice"), 500)

			expect(@user.cart).to_not eq @cart

			fill_in "Email", with: "user@example.com"
			fill_in "Password", with: "123456"

			find("input[value='Log in']").click

			@user.reload
			expect(@user.cart).to eq @cart
			expect(@user.cart.cart_items.count).to eq 2
			expect(@user.cart.cart_items.map(&:item).map(&:name).sort).to eq ["Flour", "Rice"]
		end
	end

	context "user has not added items to their guest cart" do
		scenario "the user is logged in with an empty cart" do
			visit new_user_session_path

			fill_in "Email", with: "user@example.com"
			fill_in "Password", with: "123456"

			find("input[value='Log in']").click

			@user.reload
			expect(@user.cart.cart_items).to be_empty
		end
	end
end
