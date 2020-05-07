require 'rails_helper'

RSpec.describe Cart, 'validations' do
	[:user]
	.each { |attr| it { should validate_presence_of(attr) } }
end

RSpec.describe Cart, '#create_orders' do
	context 'when there are no available containers' do
		context "when cart is full" do
			context "when provided with billing with status: success" do
				it "should create the orders without containers and returns them" do
					billing = create(:billing, status: 'success')
					cart = create(:cart, cart_items_count: 5)

					orders = cart.create_orders(billing)

					expect(orders.length).to eq 5
					expect(orders.all? { |order| order.class == Order }).to eq true
				end
			end

			context "when provided with billing with status: pending" do
				it "should create no orders and returns an empty array" do
					billing = create(:billing, status: 'pending')
					cart = create(:cart, cart_items_count: 5)

					orders = cart.create_orders(billing)

					expect(orders).to be_empty
				end
			end

			context "when provided with billing with status: failed" do

			end
		end

		context "when cart is empty" do
			context "when provided with billing with status: success" do
				it "should create no orders and returns an empty array" do
					billing = create(:billing, status: 'success')
					cart = create(:cart)

					orders = cart.create_orders(billing)

					expect(orders).to be_empty
				end
			end

			context "when provided with billing with status: pending" do
				it "should create no orders and returns an empty array" do
					billing = create(:billing, status: 'pending')
					cart = create(:cart)

					orders = cart.create_orders(billing)

					expect(orders).to be_empty
				end
			end

			context "when provided with billing with status: failed" do

			end
		end
	end

	context "when there are available containers" do
		context "when cart is full" do
			context "when there are sufficient containers" do
				context "when provided with billing with status: success" do
					it "should create orders and appropriate container orders" do
						# Default cart_item quantity is 1000
						container_1 = create(:container, size: 500)
						container_2 = create(:container, size: 1000)
						container_3 = create(:container, size: 1500)

						billing = create(:billing, status: 'success')
						cart = create(:cart, cart_items_count: 2)

						orders = cart.create_orders(billing)

						expect(orders.length).to eq 2
						expect(orders.all? { |order| order.class == Order }).to eq true

						expect(orders[0].containers).to eq [container_2]
						expect(orders[1].containers).to eq [container_3]
						expect(container_1.orders).to eq []
					end
				end

				context "when provided with billing with status pending" do
					it "should create no orders or container orders" do
						# Default cart_item quantity is 1000
						container_1 = create(:container, size: 500)
						container_2 = create(:container, size: 1000)
						container_3 = create(:container, size: 1500)

						billing = create(:billing, status: 'pending')
						cart = create(:cart, cart_items_count: 2)

						orders = cart.create_orders(billing)

						expect(orders).to be_empty

						expect(ContainerOrder.count).to eq 0
					end
				end

				context "when provided with billing with status: failed" do
					it "should create no orders or container orders" do
						# Default cart_item quantity is 1000
						container_1 = create(:container, size: 500)
						container_2 = create(:container, size: 1000)
						container_3 = create(:container, size: 1500)

						billing = create(:billing, status: 'failed')
						cart = create(:cart, cart_items_count: 2)

						orders = cart.create_orders(billing)

						expect(orders).to be_empty

						expect(ContainerOrder.count).to eq 0
					end
				end
			end

			context "when there are insufficient containers" do
				context "when provided with billing with status: success" do
					it "should create all orders and assign all containers possible" do
						# Default cart_item quantity is 1000
						container_1 = create(:container, size: 500)
						container_2 = create(:container, size: 750)

						billing = create(:billing, status: 'success')
						cart = create(:cart, cart_items_count: 2)

						orders = cart.create_orders(billing)

						expect(orders.length).to eq 2
						expect(orders.all? { |order| order.class == Order }).to eq true

						expect(orders[0].containers.sort).to eq [container_1, container_2].sort
						expect(orders[1].containers).to be_empty
					end
				end

				context "when provided with billing with status: pending" do
					it "should create no orders or container orders" do
						# Default cart_item quantity is 1000
						container_1 = create(:container, size: 500)
						container_2 = create(:container, size: 750)

						billing = create(:billing, status: 'pending')
						cart = create(:cart, cart_items_count: 2)

						orders = cart.create_orders(billing)

						expect(orders).to be_empty

						expect(ContainerOrder.count).to eq 0
					end
				end

				context "when provided with billing with status: failed" do
					it "should create no orders or container orders" do
						# Default cart_item quantity is 1000
						container_1 = create(:container, size: 500)
						container_2 = create(:container, size: 750)

						billing = create(:billing, status: 'failed')
						cart = create(:cart, cart_items_count: 2)

						orders = cart.create_orders(billing)

						expect(orders).to be_empty

						expect(ContainerOrder.count).to eq 0
					end
				end
			end
		end

		context "when cart is empty" do
			context "when provided with billing with status: success" do
				it "should create no orders or container orders" do
					# Default cart_item quantity is 1000
					create(:container, size: 500)
					create(:container, size: 1000)
					create(:container, size: 1500)

					billing = create(:billing, status: 'success')
					cart = create(:cart, cart_items_count: 0)

					orders = cart.create_orders(billing)

					expect(orders).to be_empty

					expect(ContainerOrder.count).to eq 0
				end
			end

			context "when provided with billing with status: pending" do
				it "should create no orders or container orders" do
					# Default cart_item quantity is 1000
					create(:container, size: 500)
					create(:container, size: 1000)
					create(:container, size: 1500)

					billing = create(:billing, status: 'pending')
					cart = create(:cart, cart_items_count: 0)

					orders = cart.create_orders(billing)

					expect(orders).to be_empty

					expect(ContainerOrder.count).to eq 0
				end
			end

			context "when provided with billing with status: failed" do
				it "should create no orders or container orders" do
					# Default cart_item quantity is 1000
					create(:container, size: 500)
					create(:container, size: 1000)
					create(:container, size: 1500)

					billing = create(:billing, status: 'failed')
					cart = create(:cart, cart_items_count: 0)

					orders = cart.create_orders(billing)

					expect(orders).to be_empty

					expect(ContainerOrder.count).to eq 0
				end
			end
		end
	end
end