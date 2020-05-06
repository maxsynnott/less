class AddPriceToContainers < ActiveRecord::Migration[6.0]
  def change
    add_column :containers, :price, :decimal, precision: 10, scale: 6
  end
end
