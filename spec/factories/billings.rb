FactoryBot.define do
  factory :billing do
    status { "success" }
    session_id { SecureRandom.urlsafe_base64(nil, false)[0..5] }
    amount { 10000 }

    association :user

    transient do
  		orders_count { 0 }
  	end

    after(:create) do |billing, evaluator|
  		create_list(:order, evaluator.orders_count, billing: billing)
  	end
  end
end
