FactoryBot.define do
  factory :delivery do
    price { 4.99 }
    delivered { false }
    scheduled_at { DateTime.now.next_week.change(hour: 10, min: 30) }
    delivered_at { nil }

    association :user
    association :address
  end
end
