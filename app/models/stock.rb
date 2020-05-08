class Stock < ApplicationRecord
  belongs_to :product

  has_many :stock_transactions
end
