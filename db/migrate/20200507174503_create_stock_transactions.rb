class CreateStockTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :stock_transactions do |t|
      t.integer :amount
      t.references :stock, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
