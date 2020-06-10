class RenameProductsTableToItems < ActiveRecord::Migration[6.0]
  def change
  	rename_table :products, :items
  	rename_column :cart_items, :product_id, :item_id
  	rename_column :order_items, :product_id, :item_id
  end
end
