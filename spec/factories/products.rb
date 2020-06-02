FactoryBot.define do
  factory :product do
    name { "Flour" }
    price { 0.0025 }

    association :store
  end
end
