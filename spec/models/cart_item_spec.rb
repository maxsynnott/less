require 'rails_helper'

RSpec.describe CartItem, 'validations' do
	[:cart, :quantity, :product]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }

	it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
end

RSpec.describe CartItem, "#containers" do
	let(:cart_item) { create(:cart_item, quantity: 1000) }

	context "when there are containers" do
		context "when there are more than sufficient containers" do
			before { [250, 500, 850].each { |i| create(:container, size: i) } }

			it "returns an array with the appropriate containers" do
				containers = cart_item.containers

				expect(containers.map(&:size).sort).to eq [250, 850]
			end
		end

		context "when there are exactly sufficient containers" do
			before { [500, 500].each { |i| create(:container, size: i) } }

			it "returns an array with all containers" do
				containers = cart_item.containers

				expect(containers.map(&:size)).to eq [500, 500]
			end
		end

		context "when there are insufficient containers" do
			before { [250, 500].each { |i| create(:container, size: i) } }

			it "returns an empty array" do
				containers = cart_item.containers

				expect(containers).to be_empty
			end
		end
	end

	context "when there are no containers" do
		it "returns an empty array" do
			containers = cart_item.containers

			expect(containers).to be_empty
		end
	end
end
