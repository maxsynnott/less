FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    description { "MyString" }
    user { nil }
    public { false }
  end
end
