class RenameTypeToTransactionTypeOnStockTransactions < ActiveRecord::Migration[6.0]
  def change
  	rename_column :stock_transactions, :type, :transaction_type
  end
end
