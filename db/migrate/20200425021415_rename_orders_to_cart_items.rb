class RenameOrdersToCartItems < ActiveRecord::Migration[6.0]
  def change
  	rename_table :orders, :cart_items
  end
end
