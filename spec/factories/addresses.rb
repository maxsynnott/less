FactoryBot.define do
  factory :address do
    street { "Rudi-Dutschke-Straße" }
    house_number { "26" }
    recipient { "Mr. User" }
    postal_code { "10969" }
    city { "Berlin" }
    state { "Berlin" }
    country { "DE" }
    notes { "Knock thrice" }

    association :user
  end
end
