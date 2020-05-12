FactoryBot.define do
  factory :recipe do
  	sequence :name do |n|
      "recipe_name_#{n}"
    end

    sequence :description do |n|
      "recipe_description_#{n}"
    end

    user { nil }
    public { true }

    transient do
    	recipe_items_count { 0 }
    end

    trait :with_recipe_items do
    	recipe_items_count { 3 }
    end

    after(:create) do |recipe, evaluator|
  		create_list(:recipe_item, evaluator.recipe_items_count, recipe: recipe)
  	end
  end
end
