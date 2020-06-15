class StockTransaction < ApplicationRecord
  belongs_to :stock
  belongs_to :order_item, optional: true

  after_create :adjust_stock_quantity

  private

  def adjust_stock_quantity
    stock.update(balance: stock.balance + amount)
  end
end
