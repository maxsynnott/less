FactoryBot.define do
  factory :user do
    password { "password" }
    first_name { "Max" }

    sequence :email do |n|
      "user#{n}@example.com"
    end

    transient do
    	orders_count { 0 }
      cart__cart_items_count { 0 }
    end

    trait :with_cart_item do
      cart__cart_items_count { 1 }
    end

    trait :with_order do
    	orders_count { 1 }
    end

    trait :with_orders do
    	orders_count { 3 }
    end

    after(:create) do |user, evaluator|
      create_list(:order, evaluator.orders_count, :with_delivery, user: user)
    end

    # Handling has_one association
    after(:build) do |user, evaluator|
      create(:cart, user: user, cart_items_count: evaluator.cart__cart_items_count)
    end
  end
end
