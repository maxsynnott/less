FactoryBot.define do
  factory :order do
  	payment_method_id { "pm_0123456789" }

  	# Handling has_one association
    after(:build) do |order, evaluator|
      create(:delivery, order: order)
    end

  	association :user
  end
end
