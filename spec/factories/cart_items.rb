FactoryBot.define do
  factory :cart_item do
  	quantity { 1000 }
  	
    association :item
    association :cart
  end
end
