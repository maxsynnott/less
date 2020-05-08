FactoryBot.define do
  factory :product do
    name { "Flour" }
    price { 0.0025 }

    transient do
  		stocks_count { 1 }
  	end

  	after(:create) do |product, evaluator|
  		create_list(:stock, evaluator.stocks_count, product: product)
  	end
  end
end
