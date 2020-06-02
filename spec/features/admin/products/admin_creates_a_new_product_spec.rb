require 'rails_helper'

RSpec.feature "Admin creates a product" do
	before { login_as create(:admin_user) }

	scenario "they see the created product" do
		shop = create(:shop)

		visit admin_products_path

		click_on "New Product"

		fill_in "Name", with: "Flour"
		fill_in "Description", with: "Snow white flour"
		fill_in "Price", with: "0.005"
		select shop.name, from: "product_shop_id"

		click_on "Create Product"

		expect(page).to have_selector ".flash", text: "Product was successfully created."

		expect(page).to have_text "Flour"
		expect(page).to have_text "Snow white flour"
		expect(page).to have_text "0.005"
	end
end
