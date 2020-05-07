FactoryBot.define do
  factory :address do
    line_1 { "Rudi-Dutschke-Straße 26" }
    recipient { "Mr. User" }
    postal_code { "10969" }
    city { "Berlin" }
    state { "Berlin" }
    country { "DE" }
  end
end
