class ChangePrecisionAndScaleOfPrice < ActiveRecord::Migration[6.0]
  def self.up
  	change_column :deliveries, :price, :decimal, precision: 10, scale: 6
  end

  def self.down
  	change_column :deliveries, :price, :decimal
  end
end
