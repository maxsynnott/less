class DropRecipes < ActiveRecord::Migration[6.0]
  def change
  	drop_table :recipes
  end
end
