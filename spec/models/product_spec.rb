require 'rails_helper'

RSpec.describe Product do
	context 'validations' do
		[:name, :price]
		.each { |attr| it { should validate_presence_of(attr) } }
	end

  it "should correctly display price" do
  	product = build(:product, price: 0.01)

  	expect(product.price).to eq 0.01
  	expect(product.price_for(10)).to eq 0.1
  	expect(product.price_for(25).to_cents).to eq 25
  end
end
