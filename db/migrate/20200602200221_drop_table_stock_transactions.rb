class DropTableStockTransactions < ActiveRecord::Migration[6.0]
  def change
  	drop_table :stock_transactions
  end
end
