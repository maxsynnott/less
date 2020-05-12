FactoryBot.define do
  factory :stock do
    balance { 1000 }

    association :product
  end
end
