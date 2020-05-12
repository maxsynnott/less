class StockTransaction < ApplicationRecord
  belongs_to :stock
  belongs_to :order, optional: true

  after_create :adjust_stock_quantity

  # Getter would currently be unused, add if neccessary
  def type=(value)
  	self.transaction_type = value
  end

  private

  def adjust_stock_quantity
    stock.update(balance: stock.balance + amount)
  end
end
