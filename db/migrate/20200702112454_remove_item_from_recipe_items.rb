class RemoveItemFromRecipeItems < ActiveRecord::Migration[6.0]
  def change
    remove_reference :recipe_items, :item, null: false, foreign_key: true
  end
end
