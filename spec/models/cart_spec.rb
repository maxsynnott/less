require 'rails_helper'

RSpec.describe Cart, 'validations' do
	[]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end

RSpec.describe Cart, "#add_unit" do
	let(:cart) { create(:cart) }
	let(:unit) { create(:unit) }

	context "when cart has a cart_item with same unit" do
		before { cart.cart_items << create(:cart_item, unit: unit, quantity: 100) }

		context "when provided with amount" do
			it "adds given amount to existing quantity" do
				expect(cart.cart_items.count).to eq 1

				cart.add_unit(unit, 100)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 200
				expect(cart_item.unit).to eq unit
			end
		end

		context "when not provided with amount" do
			it "adds 1 to existing quantity" do
				expect(cart.cart_items.count).to eq 1

				cart.add_unit(unit)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 101
				expect(cart_item.unit).to eq unit
			end
		end
	end

	context "when cart doesn't have a cart with same item" do
		context "when provided with amount" do
			it "creates a new cart_item with given amount" do
				expect(cart.cart_items.count).to eq 0

				cart.add_unit(unit, 100)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 100
				expect(cart_item.unit).to eq unit
			end
		end

		context "when not provided with amount" do
			it "creates a new cart_item with quantity 1" do
				expect(cart.cart_items.count).to eq 0

				cart.add_unit(unit)

				cart.reload

				expect(cart.cart_items.count).to eq 1
				
				cart_item = cart.cart_items.first

				expect(cart_item.quantity).to eq 1
				expect(cart_item.unit).to eq unit
			end
		end
	end
end
