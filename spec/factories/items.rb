FactoryBot.define do
  factory :item do
    name { "Flour" }
    price { 0.0025 }

  	transient do
  		units_count { 0 }
  	end

    trait :with_unit do
      units_count { 1 }
    end

  	trait :with_units do
  		units_count { 3 }
  	end

  	after(:create) do |item, evaluator|
  		create_list(:unit, evaluator.units_count, item: item)
  	end
  end
end
