class DropRecipeItems < ActiveRecord::Migration[6.0]
  def change
  	drop_table :recipe_items
  end
end
