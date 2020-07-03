FactoryBot.define do
  factory :unit do
    base_units { "1" }
    name { "gram" }
    default { true }

    item
  end
end
