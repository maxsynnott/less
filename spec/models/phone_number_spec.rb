require 'rails_helper'

RSpec.describe PhoneNumber do
	context 'validations' do
		[:user, :number]
		.each { |attr| it { should validate_presence_of(attr) } }
	end
end
