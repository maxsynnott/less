FactoryBot.define do
  factory :order do
    quantity { 500 }
    price { 0.005 }

    association :delivery
  end
end
