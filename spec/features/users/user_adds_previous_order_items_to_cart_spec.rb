require 'rails_helper'

RSpec.feature "User adds previous order items to cart", js: true do
	before do
		@user = create(:user)

		@order = create(:order, user: @user)

		@order.order_items = [
			build(:order_item, quantity: 500),
			build(:order_item, quantity: 5, unit: create(:unit, name: 'kg', base_units: 1000, default: false))
		]

		@order.save

		login_as @user, scope: :user
	end

	context "they have a full cart" do
		context "they have the same item in cart" do
			context "the item has a different unit" do
				before do
					unit = create(:unit, item: @order.order_items.first.item)
					create(:cart_item, cart: @user.cart, unit: unit)
				end

				scenario "the cart_item is added alongside the existing cart_item" do
					visit orders_path

					find("a[data-toggle='collapse']").click

					click_on "Add to cart", match: :first

					expect(page).to have_css "#cart_count", text: '2'

					click_on "Cart"

					expect(page).to have_css(".cart-item-partial", text: "Flour", count: 2)
				end
			end

			context "the item has the same unit" do
				before do
					create(:cart_item, cart: @user.cart, unit: @order.order_items.first.unit)
				end

				scenario "the item's unit is added to the existing cart_item" do
					visit orders_path

					find("a[data-toggle='collapse']").click

					click_on "Add to cart", match: :first

					expect(page).to have_css "#cart_count", text: '1'

					click_on "Cart"

					expect(page).to have_css(".cart-item-partial", text: "Flour", count: 1)
				end
			end
		end
	end

	context "they have an empty cart" do
		context "they add all items to cart" do
			scenario "the cart_items are added to cart" do
				visit orders_path

				find("a[data-toggle='collapse']").click

				click_on "Add all items to cart"

				expect(page).to have_css "#cart_count", text: '2'

				click_on "Cart"

				expect(page).to have_css(".cart-item-partial", text: "Flour", count: 2)
			end
		end

		context "they add a single item to cart" do
			scenario "the cart_item is added to cart" do
				visit orders_path

				find("a[data-toggle='collapse']").click

				click_on "Add to cart", match: :first

				expect(page).to have_css "#cart_count", text: '1'

				click_on "Cart"

				expect(page).to have_css(".cart-item-partial", text: "Flour", count: 1)
			end
		end
	end
end