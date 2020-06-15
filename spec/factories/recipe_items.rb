FactoryBot.define do
  factory :recipe_item do
    quantity { 250 }

    association :item
    association :recipe
  end
end
