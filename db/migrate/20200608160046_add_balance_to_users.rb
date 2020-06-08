class AddBalanceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :balance, :decimal, precision: 10, scale: 6, default: 0.00
  end
end
