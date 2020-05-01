require 'rails_helper'

RSpec.describe Cart do
  context 'validations' do
  	[:user]
  	.each { |attr| it { should validate_presence_of(attr) } }
  end
end
