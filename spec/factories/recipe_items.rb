FactoryBot.define do
  factory :recipe_item do
    quantity { 250 }

    association :unit
    association :recipe
  end
end
