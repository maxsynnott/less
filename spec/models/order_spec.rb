require 'rails_helper'

RSpec.describe Order, 'validations' do
	[]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
