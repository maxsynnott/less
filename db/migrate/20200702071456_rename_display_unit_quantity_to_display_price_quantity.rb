class RenameDisplayUnitQuantityToDisplayPriceQuantity < ActiveRecord::Migration[6.0]
  def change
  	rename_column :items, :display_unit_quantity, :display_price_quantity
  end
end
