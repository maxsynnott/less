FactoryBot.define do
  factory :delivery do
    user { nil }
    price { "9.99" }
    delivered { false }
    address { nil }
    scheduled_at { "2020-04-27 14:02:54" }
    delivered_at { "2020-04-27 14:02:54" }
  end
end
