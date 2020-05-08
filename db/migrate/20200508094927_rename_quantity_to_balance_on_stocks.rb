class RenameQuantityToBalanceOnStocks < ActiveRecord::Migration[6.0]
  def change
  	rename_column :stocks, :quantity, :balance
  end
end
