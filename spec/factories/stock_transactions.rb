FactoryBot.define do
  factory :stock_transaction do
    amount { 1 }
    stock { nil }
    order { nil }
  end
end
