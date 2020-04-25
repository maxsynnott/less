FactoryBot.define do
  factory :address do
    street { "MyString" }
    house_number { "MyString" }
    recipient { "MyString" }
    postal_code { "MyString" }
    city { "MyString" }
    state { "MyString" }
    country { "MyString" }
  end
end
