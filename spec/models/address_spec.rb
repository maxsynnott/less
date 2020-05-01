require 'rails_helper'

RSpec.describe Address do
  context 'validations' do
  	[:street, :house_number, :postal_code, :country, :user]
  	.each { |attr| it { should validate_presence_of(attr) } }
  end
end
