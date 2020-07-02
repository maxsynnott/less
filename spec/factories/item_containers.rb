FactoryBot.define do
  factory :item_container do
  	association :item
  	association :container
  end
end
