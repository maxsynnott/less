require 'rails_helper'

RSpec.feature "Admin deletes a item" do
	before do 
		login_as create(:admin_user)
		create(:item, name: "Spinach")
	end

	scenario "they no longer see the item" do
		visit admin_items_path

		expect(page).to have_text "Spinach"

		click_on "Delete"

		expect(page).to have_selector ".flash", text: "Item was successfully destroyed."

		expect(page).to_not have_text "Spinach"
	end
end
