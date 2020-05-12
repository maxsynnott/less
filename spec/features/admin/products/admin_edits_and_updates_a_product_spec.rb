require 'rails_helper'

RSpec.feature "Admin edits and updates a product" do
	before do 
		login_as create(:admin_user) 
		create(:product, name: "Oregano")
	end

	scenario "they see the updated attributes" do
		visit admin_products_path

		expect(page).to have_text "Oregano"

		click_on "Edit"

		fill_in "Name", with: "Sugar"
		fill_in "Description", with: "Cuban Sugar"
		fill_in "Price", with: "0.01"

		click_on "Update Product"

		expect(page).to have_selector ".flash", text: "Product was successfully updated."

		expect(page).to have_text "Sugar"
		expect(page).to have_text "Cuban Sugar"
		expect(page).to have_text "0.01"
	end
end
