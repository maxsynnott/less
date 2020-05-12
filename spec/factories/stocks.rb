FactoryBot.define do
  factory :stock do
    balance { 10000 }

    association :product
  end
end
