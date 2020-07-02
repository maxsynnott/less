FactoryBot.define do
  factory :item_container_type do
  	association :item
  	association :container_type
  end
end
