class AddTypeToStockTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_transactions, :type, :string
  end
end
