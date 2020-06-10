require "rails_helper"

RSpec.describe DeliveriesController, "#update" do
	before { sign_in create(:user, :with_order) }
	let(:delivery) { controller.current_user.deliveries.first }

	context "when provided with a valid scheduled_at" do
		it "correctly updates the delivery and redirects_to orders_path" do
			patch :update, params: { id: delivery.id, delivery: { scheduled_at: DateTime.now.next_week.to_s } }

			delivery.reload

			expect(assigns(:delivery)).to eq delivery
			expect(delivery.scheduled_at).to eq DateTime.now.next_week

			expect(response).to redirect_to orders_path
		end
	end
end
