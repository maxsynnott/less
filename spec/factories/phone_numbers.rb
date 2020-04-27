FactoryBot.define do
  factory :phone_number do
    number { "MyString" }
    country_code { "MyString" }
    user { nil }
  end
end
