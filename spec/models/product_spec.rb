require 'rails_helper'

RSpec.describe Product, 'validations' do
	[:name, :price]
	.each { |attr| it { should validate_presence_of(attr) } }
end
