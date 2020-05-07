FactoryBot.define do
  factory :billing do
    status { "success" }
    session_id { SecureRandom.urlsafe_base64(nil, false)[0..5] }
    amount { 10000 }

    association :user
  end
end
