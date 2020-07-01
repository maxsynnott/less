require 'rails_helper'

RSpec.feature "User adds items to cart" do
	before do
		create(:item, name: "Flour")
		create(:item, name: "Rice")

		login_as create(:user), scope: :user
	end

	scenario "the items are added to cart", js: true do
		visit items_path

		expect(page).to have_css "#cart_count", text: '0'

		click_on "Flour"

		fill_in "Quantity", with: "1000"

		sleep(0.2) # Currently required for modal, should find a cleaner way to do this
		click_on "Add to cart"

		expect(page).to have_css "#cart_count", text: '1'

		click_on "Rice"

		fill_in "Quantity", with: "500"

		sleep(0.2)
		click_on "Add to cart"

		expect(page).to have_css "#cart_count", text: '2'

		click_on "Cart"

		expect(page).to have_css("input#cart_item_quantity[value='1000']")
		expect(page).to have_css("input#cart_item_quantity[value='500']")

		expect(page).to have_link "Checkout"
	end

	context "from show page" do
		scenario "the items are added to cart", js: true do
			visit items_path

			expect(page).to have_css "#cart_count", text: '0'

			click_on "Flour"

			click_on "More product information"

			find("#carts_show input#cart_item_quantity").fill_in with: 1000

			click_on "Add to cart"

			expect(page).to have_css "#cart_count", text: '1'

			click_on "Cart"

			expect(page).to have_css("input#cart_item_quantity[value='1000']")

			expect(page).to have_link "Checkout"
		end
	end
end
