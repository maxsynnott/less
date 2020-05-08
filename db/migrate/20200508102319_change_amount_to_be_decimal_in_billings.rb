class ChangeAmountToBeDecimalInBillings < ActiveRecord::Migration[6.0]
  def self.up
  	change_column :billings, :amount, :decimal, precision: 10, scale: 6
  end

  def self.down
  	change_column :billings, :amount, :integer
  end
end
