require 'rails_helper'

RSpec.describe Container, 'validations' do
	[:size]
	.each { |attr| it { should validate_presence_of(attr) } }
end
