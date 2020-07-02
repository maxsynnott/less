class AddUnitToRecipeItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipe_items, :unit, null: false, foreign_key: true
  end
end
