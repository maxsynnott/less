class AddUnitsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :units, :string, array: true, default: ["gram"]
  end
end
