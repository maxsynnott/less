FactoryBot.define do
  factory :unit do
    base_units { "1" }
    name { "gram" }

    association :item
  end
end
