FactoryBot.define do
  factory :order do
  	transient do
  		deliveries_count { 0 }
  	end

  	trait :with_delivery do
  		deliveries_count { 1 }
  	end

  	trait :with_deliveries do
  		deliveries_count { 3 }
  	end

  	after(:create) do |order, evaluator|
  	  create_list(:delivery, evaluator.deliveries_count, order: order)
  	end

  	association :user
  end
end
