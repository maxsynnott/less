require 'rails_helper'

RSpec.describe Cart, 'validations' do
	[:user]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end

RSpec.describe Cart, "#add_product" do
	let(:cart) { create(:cart) }
	let(:product) { create(:product) }

	context "when cart has a cart_item with same product" do
		before { cart.cart_items << create(:cart_item, product: product, quantity: 100) }

		context "when provided with amount" do
			it "adds given amount to existing quantity" do
				expect(cart.cart_items.count).to eq 1

				cart.add_product(product, 100)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 200
				expect(cart_item.product).to eq product
			end
		end

		context "when not provided with amount" do
			it "adds 1 to existing quantity" do
				expect(cart.cart_items.count).to eq 1

				cart.add_product(product)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 101
				expect(cart_item.product).to eq product
			end
		end
	end

	context "when cart doesn't have a cart with same product" do
		context "when provided with amount" do
			it "creates a new cart_item with given amount" do
				expect(cart.cart_items.count).to eq 0

				cart.add_product(product, 100)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 100
				expect(cart_item.product).to eq product
			end
		end

		context "when not provided with amount" do
			it "creates a new cart_item with quantity 1" do
				expect(cart.cart_items.count).to eq 0

				cart.add_product(product)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 1
				expect(cart_item.product).to eq product
			end
		end
	end
end

# Just temp touching
RSpec.describe Cart, "#line_items" do
	context "when there are cart_items in the cart" do
		let(:cart) { create(:cart, :with_cart_items) }

		it "returns array containing line_items" do
			line_items = cart.line_items

			expect(line_items.count).to eq 3
		end
	end
end