FactoryBot.define do
  factory :recipe_item do
    quantity { 250 }

    association :product
    association :recipe
  end
end
