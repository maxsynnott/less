require 'rails_helper'

RSpec.describe Container do
  context 'validations' do
  	[:size]
  	.each { |attr| it { should validate_presence_of(attr) } }
  end
end
