FactoryBot.define do
  factory :order do
  	payment_method_id { "pm_0123456789" }

  	transient do
  		order_items_count { 0 }
  	end

    trait :with_order_item do
      order_items_count { 1 }
    end

  	trait :with_order_items do
  		order_items_count { 3 }
  	end

  	delivery { association :delivery, order: @instance }

  	association :user

  	after(:create) do |order, evaluator|
  		create_list(:order_item, evaluator.order_items_count, order: order)
  	end
  end
end
