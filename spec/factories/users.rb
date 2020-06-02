FactoryBot.define do
  factory :user do
    password { "password" }

    sequence :email do |n|
      "user#{n}@example.com"
    end

    trait :with_cart_item do
      cart { create(:cart, cart_items_count: 1) }
    end
  end
end
