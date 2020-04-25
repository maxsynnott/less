require 'rails_helper'

RSpec.describe Product do
  it "should correctly display price" do
  	product = build(:product, price: 0.01)

  	expect(product.price).to eq 0.01
  	expect(product.price_for(10)).to eq 0.1
  	expect(product.cents_price_for(25)).to eq 25
  end
end
