FactoryBot.define do
  factory :user do
    password { "password" }

    sequence :email do |n|
      "user#{n}@example.com"
    end

    trait :with_cart_item do
      cart { create(:cart, cart_items_count: 1) }
    end

    transient do
    	orders_count { 0 }
    end

    trait :with_order do
    	orders_count { 1 }
    end

    trait :with_orders do
    	orders_count { 3 }
    end

    after(:create) do |user, evaluator|
    	create_list(:order, evaluator.orders_count, user: user)
    end
  end
end
