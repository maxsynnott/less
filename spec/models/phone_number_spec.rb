require 'rails_helper'

RSpec.describe PhoneNumber, 'validations' do
	[:user, :number]
	.each { |attr| it { should validate_presence_of(attr) } }
end
