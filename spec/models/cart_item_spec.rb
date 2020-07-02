require 'rails_helper'

RSpec.describe CartItem, "validations" do
	[:cart, :quantity, :unit]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }

	it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
end

