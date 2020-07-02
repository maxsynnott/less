class RemoveDisplayUnitOnItems < ActiveRecord::Migration[6.0]
  def change
  	remove_column :items, :display_unit
  	rename_column :items, :display_price_quantity, :display_quantity
  end
end
