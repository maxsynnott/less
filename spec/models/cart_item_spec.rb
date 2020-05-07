require 'rails_helper'

RSpec.describe CartItem, 'validations' do
	[:cart, :quantity, :product]
	.each { |attr| it { should validate_presence_of(attr) } }
end
