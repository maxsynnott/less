FactoryBot.define do
  factory :admin_user do
    password { "password" }

    sequence :email do |n|
      "admin#{n}@example.com"
    end
  end
end
