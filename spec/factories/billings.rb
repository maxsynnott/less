FactoryBot.define do
  factory :billing do
    user { nil }
    status { "MyString" }
    token { "MyString" }
    amount { 1 }
  end
end
