FactoryBot.define do
  factory :store do
    sequence :name do |n|
      "Shop ##{n}"
    end
    
    association :address
  end
end
