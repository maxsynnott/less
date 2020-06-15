class RenameProductIdToItemIdOnStocks < ActiveRecord::Migration[6.0]
  def change
  	rename_column :stocks, :product_id, :item_id
  end
end
