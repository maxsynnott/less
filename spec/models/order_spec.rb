require 'rails_helper'

RSpec.describe Order, 'validations' do
	[:quantity, :price]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
