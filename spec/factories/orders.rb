FactoryBot.define do
  factory :order do

  	# Handling has_one association
    after(:build) do |order, evaluator|
      create(:delivery, order: order)
    end

  	association :user
  end
end
