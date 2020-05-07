FactoryBot.define do
  factory :cart_item do
  	quantity { 1000 }
  	
    association :product
    association :cart
  end
end
