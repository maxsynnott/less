FactoryBot.define do
  factory :delivery do
    price { 4.99 }
    delivered { false }
    scheduled_at { (DateTime.now.next_week + 2.days).change(hour: 14, min: 00) }
    delivered_at { nil }
    address { "rudi dutschke str. 26" }
    phone { "+494242424242" }

    association :order
  end
end
