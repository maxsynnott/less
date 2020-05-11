FactoryBot.define do
  factory :user do
    password { "password" }

    sequence :email do |n|
      "user#{n}@example.com"
    end
  end
end
