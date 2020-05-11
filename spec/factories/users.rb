FactoryBot.define do
  factory :user do
    password { "password" }

    sequence :email do |n|
      "user#{n}@example.com"
    end

    transient do
  		orders_count { 0 }
  	end

  	after(:create) do |user, evaluator|
  		if evaluator.orders_count.positive?
    		create(:billing, orders_count: evaluator.orders_count, user: user)
    	end
  	end
  end
end
