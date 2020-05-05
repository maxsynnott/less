class Billing < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true

  has_many :orders
end
