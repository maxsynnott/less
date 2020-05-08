class StockTransaction < ApplicationRecord
  belongs_to :stock
  belongs_to :order, optional: true

  after_create :adjust_stock_quantity

  def adjust_stock_quantity
  	stock.update(quantity: stock.quantity + amount)
  end

  def type
  	transaction_type
  end

  def type=(value)
  	self.transaction_type = value
  end
end
