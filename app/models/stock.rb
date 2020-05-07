class Stock < ApplicationRecord
  belongs_to :product
  belongs_to :order, optional: true

  has_many :stock_transactions
end
