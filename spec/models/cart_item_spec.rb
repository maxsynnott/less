require 'rails_helper'

RSpec.describe CartItem do
  context 'validations' do
  	[:cart, :quantity, :product]
  	.each { |attr| it { should validate_presence_of(attr) } }
  end
end
