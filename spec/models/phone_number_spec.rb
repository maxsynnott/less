require 'rails_helper'

RSpec.describe PhoneNumber, 'validations' do
	[:user, :number]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
