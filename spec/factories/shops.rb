FactoryBot.define do
  factory :shop do
    sequence :name do |n|
      "Shop ##{n}"
    end
    
    association :address
  end
end
