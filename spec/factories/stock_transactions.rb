FactoryBot.define do
  factory :stock_transaction do
    amount { 1 }
    stock { nil }
    order_item { nil }
  end
end
