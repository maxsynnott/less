require 'rails_helper'

RSpec.describe Integer, "#to_money" do
	context "when the method is called on a positive integer" do
		let(:integer) { Integer(2048) }

		it "returns a integer divided by 100 as a BigDecimal" do
			money = integer.to_money

			expect(money).to eq 20.48
			expect(money.class).to eq BigDecimal
		end
	end

	context "when the method is called on a negative integer" do
		let(:integer) { Integer(-1024) }

		it "returns a integer divided by 100 as a BigDecimal" do
			money = integer.to_money

			expect(money).to eq -10.24
			expect(money.class).to eq BigDecimal
		end
	end

	context "when the method is called on the integer 0" do
		let(:integer) { Integer(0) }

		it "returns 0 as a BigDecimal" do
			money = integer.to_money

			expect(money).to eq 0
			expect(money.class).to eq BigDecimal
		end
	end
end
