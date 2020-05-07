require 'rails_helper'

RSpec.describe Address, 'validations' do
	[:line_1, :postal_code, :country]
	.each { |attr| it { should validate_presence_of(attr) } }
end
