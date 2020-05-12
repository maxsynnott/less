require "rails_helper"

RSpec.describe Stripe::Handlers::CheckoutEvent, "#handle_checkout_session_completed" do
	before { StripeMock.start }
	after { StripeMock.stop }

	# This could use some cleaning up
	context "when provided with a valid event" do
		let(:cart) { create(:user, cart: create(:cart, cart_items_count: 2)).cart } # Work around odd bug of multiple cart creation (need to fix root cause)
		let(:address) { {"city":"Berlin","country":"DE","line1":"Rudi Dutschke str. 26","line2":"","postal_code":"10969","state":"Berlin"} }

		it "creates the appropriate model instances" do
			# View spec/fixtures/stripe_webhooks/checkout.session.completed.json
			event = StripeMock.mock_webhook_event('checkout.session.completed')
			event.data.object.metadata = cart.to_metadata
			event.data.object.shipping.address = address
			event.data.object.shipping.name = "Le Wagon"

			Stripe::Handlers::CheckoutEvent.new.call(event)

			billing = Billing.last
			orders = billing.orders

			expect(billing).to have_attributes(
				user_id: cart.user.id,
				status: "success",
				amount: cart.total,
				session_id: /(cs_|test_){2}\w+/,
				# pretty_generate used as is how stripe returns it
				metadata: JSON.pretty_generate(cart.to_metadata)
			)

			expect(orders.length).to eq 2
			# Checking that all order's deliveries are equal
			expect(orders.map(&:delivery).uniq.length).to eq 1

			delivery = orders.first.delivery

			expect(delivery).to have_attributes(
				price: 0.00,
				delivered: false,
				# This is only valid while multiple deliveries are allowed per slot
				scheduled_at: Delivery.next_available_datetime
			)

			address = delivery.address

			expect(address).to have_attributes(
				recipient: "Le Wagon",
				line_1: "Rudi Dutschke str. 26",
				line_2: "",
				postal_code: "10969",
				city: "Berlin",
				state: "Berlin",
				country: "DE"
			)

			cart.reload
			expect(cart.empty?).to eq true
		end
	end
end
