require 'rails_helper'

RSpec.describe Billing, "#create_orders" do
	context "when metadata is filled including containers" do
		let(:billing) do
			create(:container, size: 500)
			create(:container, size: 1000)
			create(:container, size: 1500)

			cart_item_1 = create(:cart_item, quantity: 1000)
			cart_item_2 = create(:cart_item, quantity: 1750)

			cart = create(:cart, cart_item_ids: [cart_item_1.id, cart_item_2.id])

			# Populates metadata with 2 items with containers
			create(:billing, metadata: cart.to_metadata.to_json)
		end

		context "when status: success" do
			before { billing.status = "success" }

			it "creates orders and appropriate container orders" do
				orders = billing.create_orders

				expect(orders.length).to eq 2
				expect(orders.all? { |order| order.class == Order }).to eq true

				expect(orders[0].containers.length).to eq 1
				expect(orders[1].containers.length).to eq 2
			end
		end

		context "when status: pending" do
			before { billing.status = "pending" }

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end

		context "when status: failed" do
			before { billing.status = "failed" }

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end
	end

	context "when metadata is filled excluding containers" do
		let(:billing) do
			cart_item_1 = create(:cart_item, quantity: 1000)
			cart_item_2 = create(:cart_item, quantity: 1750)

			cart = create(:cart, cart_item_ids: [cart_item_1.id, cart_item_2.id])

			# Populates metadata with 2 items without containers
			create(:billing, metadata: cart.to_metadata.to_json)
		end

		context "when status: success" do
			before { billing.status = "success" }

			it "creates orders and no container orders" do
				orders = billing.create_orders

				expect(orders.length).to eq 2
				expect(orders.all? { |order| order.class == Order }).to eq true

				expect(ContainerOrder.count).to eq 0
			end
		end

		context "when status: pending" do
			before { billing.status = "pending" }

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end

		context "when status: failed" do
			before { billing.status = "failed" }

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end
	end

	context "when metadata is nil" do
		let(:billing) { create(:billing, metadata: nil) }

		context "when status: success" do
			before { billing.status = 'success' }

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end

		context "when status: pending" do
			before { billing.status = "pending" }

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end

		context "when status: failed" do
			before { billing.status = "failed"}

			it "creates no orders or container orders" do
				orders = billing.create_orders

				expect(orders).to be_empty
				expect(ContainerOrder.count).to eq 0
			end
		end
	end
end
