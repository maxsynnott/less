require 'rails_helper'

RSpec.describe ContainerOrder, "#checked_out?" do
	context "there are no existing container_orders" do
		it "should return false" do
			container = create(:container)

			expect(container.checked_out?).to eq false
		end
	end

	context "there are existing container_orders" do
		it "should return true when a container hasn't been returned" do
			container = create(:container)
			order_1 = create(:order)
			order_2 = create(:order)

			order_1.check_out(container)
			container.return

			order_2.check_out(container)

			expect(container.checked_out?).to eq true
		end

		it "should return false when all container_orders have been returned" do
			container = create(:container)
			order_1 = create(:order)
			order_2 = create(:order)

			order_1.check_out(container)
			container.return

			order_2.check_out(container)
			container.return

			expect(container.checked_out?).to eq false
		end
	end
end
