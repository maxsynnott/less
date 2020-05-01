require 'rails_helper'

RSpec.describe User do
	context 'validations' do
		[:cart]
		.each { |attr| it { should validate_presence_of(attr) } }
	end
end
