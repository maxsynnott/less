FactoryBot.define do
  factory :cart_item do
  	quantity { 1000 }
  	
    association :unit
    association :cart
  end
end
