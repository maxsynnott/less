require 'rails_helper'

RSpec.describe User, 'validations' do
	[:cart]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
