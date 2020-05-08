class StockTransaction < ApplicationRecord
  belongs_to :stock
  belongs_to :order, optional: true
end
