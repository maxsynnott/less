class CreateRecipeItems < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_items do |t|
      t.integer :quantity
      t.references :product, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
