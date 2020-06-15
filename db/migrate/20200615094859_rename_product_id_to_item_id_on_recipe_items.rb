class RenameProductIdToItemIdOnRecipeItems < ActiveRecord::Migration[6.0]
  def change
  	rename_column :recipe_items, :product_id, :item_id
  end
end
