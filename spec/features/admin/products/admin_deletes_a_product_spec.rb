require 'rails_helper'

RSpec.feature "Admin deletes a product" do
	before do 
		login_as create(:admin_user)
		create(:product, name: "Spinach")
	end

	scenario "they no longer see the product" do
		visit admin_products_path

		expect(page).to have_text "Spinach"

		click_on "Delete"

		expect(page).to have_selector ".flash", text: "Product was successfully destroyed."

		expect(page).to_not have_text "Spinach"
	end
end
