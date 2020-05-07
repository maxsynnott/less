require 'rails_helper'

RSpec.feature "Admin Product CRUD" do
	before do
		# Odd issue where logging in as standard user will also grant admin access however this is only the case in testing
		admin = create(:admin_user)
		login_as(admin)
	end

	scenario "Admin creates a new product" do
		visit admin_products_path

		click_on "New Product"

		fill_in "Name", with: "Flour"
		fill_in "Description", with: "Snow white flour"
		fill_in "Price", with: "0.005"

		click_on "Create Product"

		expect(page).to have_selector ".flash", text: "Product was successfully created."

		expect(page).to have_text "Flour"
		expect(page).to have_text "Snow white flour"
		expect(page).to have_text "0.005"
	end

	scenario "Admin edits and updates a product" do
		product = create(:product, name: "Oregano")

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

	scenario "Admin deletes a product" do
		product = create(:product, name: "Spinach")

		visit admin_products_path

		expect(page).to have_text "Spinach"

		click_on "Delete"

		expect(page).to have_selector ".flash", text: "Product was successfully destroyed."

		expect(page).to_not have_text "Spinach"
	end
end