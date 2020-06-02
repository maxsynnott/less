FactoryBot.define do
  factory :shop do
    name { "MyString" }
    
    association :address
  end
end
