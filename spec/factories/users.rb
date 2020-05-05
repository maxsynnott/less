FactoryBot.define do
  factory :user do
    password { "password" }

    sequence :email do |n|
      "user#{n}@example.com"
    end

    after(:build) do |user, _|
    	user.cart = FactoryBot.build(:cart, user: user)
    end
  end
end
