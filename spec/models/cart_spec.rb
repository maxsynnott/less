require 'rails_helper'

RSpec.describe Cart, 'validations' do
	[:user]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
