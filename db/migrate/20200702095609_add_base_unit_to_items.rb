class AddBaseUnitToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :base_unit, :string
  end
end
