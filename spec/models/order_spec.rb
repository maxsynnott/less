require 'rails_helper'

RSpec.describe Order do
	context 'validations' do
		[:product, :user, :quantity, :price, :billing]
		.each { |attr| it { should validate_presence_of(attr) } }
	end
end
