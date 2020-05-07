FactoryBot.define do
  factory :order do
    quantity { 500 }
    price { 0.005 }

    association :billing
    association :delivery
    association :product
  end
end
