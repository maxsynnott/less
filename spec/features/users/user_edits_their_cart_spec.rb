require 'rails_helper'

RSpec.feature "User edits their cart" do
	before do
		StripeMock.start

		user = create(:user)

		user.cart.add_item(create(:item, name: "Flour", price: 2), 1000)
		user.cart.add_item(create(:item, name: "Rice", price: 1), 500)

		login_as user, scope: :user
	end

	after { StripeMock.stop }

	scenario "the cart items are changed accordingly and checkout is accessible", js: true do
		visit root_path

		click_on "Cart"

		total = find("#checkout_button_total")

		expect(total.text).to eq "2.500,00 €"

		expect(page).to have_css("input#cart_item_quantity.disabled[value='1000']")

		find("button[data-action='cart-item#editButton']", match: :first).click()

		find("input#cart_item_quantity", class: "!disabled", match: :one).fill_in with: "2500"

		find("button[data-action='cart-item#submitForm']", match: :one).click()

		expect(find("input#cart_item_quantity", class: "disabled", match: :first).value).to eq '2500'

		expect(total.text).to eq "5.500,00 €"

		expect(all("input#cart_item_quantity").last.value).to eq '500'
		expect(all("input#cart_item_quantity").last.disabled?).to eq true

		find("a[data-action='cart-item#destroyItem']", match: :first).click()

		expect(all("form[data-controller='cart-item']", class: "!fade").count).to eq 1

		expect(total.text).to eq "500,00 €"

		click_on "Checkout"

		expect(page).to have_content "500,00 €"
		expect(page).to have_content "Rice"
		expect(page).to have_content "500 grams"
		expect(page).to have_css "button[data-target='checkout.submitButton']"
	end
end
