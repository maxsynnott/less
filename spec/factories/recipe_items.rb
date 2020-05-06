FactoryBot.define do
  factory :recipe_item do
    quantity { 1 }
    product { nil }
    recipe { nil }
  end
end
