require "rails_helper"

RSpec.describe BigDecimal, "#to_cents" do
	context "when the method is called on a positive big_decimal" do
		context "when the big_decimal has 2 decimal places" do
			let(:big_decimal) { BigDecimal("20.48") }

			it "returns the exact cents as an Integer instance" do
				cents = big_decimal.to_cents

				expect(cents).to eq 2048
				expect(cents).to be_an_instance_of Integer
			end
		end

		context "when the big_decimal has 6 decimal places" do
			let(:big_decimal) { BigDecimal("987.654321") }

			it "returns the cents as an Integer instance rounded to the closest integer" do
				cents = big_decimal.to_cents

				expect(cents).to eq 98765
				expect(cents).to be_an_instance_of Integer
			end
		end
	end

	context "when the method is called on a negative big_decimal" do
		context "when the big_decimal has 2 decimal places" do
			let(:big_decimal) { BigDecimal("-12.89") }

			it "returns the exact cents as a negative Integer instance" do
				cents = big_decimal.to_cents

				expect(cents).to eq -1289
				expect(cents).to be_an_instance_of Integer
			end
		end

		context "when the big_decimal has 6 decimal places" do
			let(:big_decimal) { BigDecimal("-12.345678") }

			it "returns the cents as a negative Integer instance rounded to the closest integer" do
				cents = big_decimal.to_cents

				expect(cents).to eq -1235
				expect(cents).to be_an_instance_of Integer
			end
		end
	end

	context "when the method is called on the big_decimal 0.000000" do
		let(:big_decimal) { BigDecimal("0.000000") }

		it "returns 0 as an Integer instance" do
			cents = big_decimal.to_cents

			expect(cents).to eq 0
			expect(cents).to be_an_instance_of Integer
		end
	end
end