FactoryBot.define do
  factory :cart do
    association :user

  	transient do
  		cart_items_count { 0 }
  	end

  	trait :with_cart_items do
  		cart_items_count { 3 }
  	end

  	after(:create) do |cart, evaluator|
  		create_list(:cart_item, evaluator.cart_items_count, cart: cart)
  	end
  end
end
