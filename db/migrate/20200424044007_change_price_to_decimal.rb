class ChangePriceToDecimal < ActiveRecord::Migration[6.0]
  def self.up
  	change_column :products, :price, :decimal, precision: 10, scale: 6
  end

  def self.down
  	change_column :products, :price, :integer
  end
end
