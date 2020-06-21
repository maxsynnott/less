require 'rails_helper'

RSpec.feature "Admin creates a item" do
	before { login_as create(:admin_user) }

	scenario "they see the created item" do
		visit admin_items_path

		click_on "New Item"

		fill_in "Name", with: "Flour"
		fill_in "Description", with: "Snow white flour"
		fill_in "Price", with: "0.005"

		click_on "Create Item"

		expect(page).to have_selector ".flash", text: "Item was successfully created."

		expect(page).to have_text "Flour"
		expect(page).to have_text "Snow white flour"
		expect(page).to have_text "0.005"
	end
end
