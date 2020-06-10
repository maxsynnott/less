FactoryBot.define do
  factory :item do
    name { "Flour" }
    price { 0.0025 }

    association :store
  end
end
