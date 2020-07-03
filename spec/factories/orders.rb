FactoryBot.define do
  factory :order do
  	payment_method_id { "pm_0123456789" }

  	delivery { association :delivery, order: @instance }

  	association :user
  end
end
