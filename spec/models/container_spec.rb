require 'rails_helper'

RSpec.describe Container, 'validations' do
	[:size]
	.each { |attr| it { is_expected.to validate_presence_of(attr) } }
end
