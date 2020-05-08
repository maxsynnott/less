require 'rails_helper'

RSpec.describe Product, 'validations' do
	[:name, :price]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
