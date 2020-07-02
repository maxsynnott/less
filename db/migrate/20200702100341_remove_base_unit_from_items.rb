class RemoveBaseUnitFromItems < ActiveRecord::Migration[6.0]
  def change
  	remove_column :items, :base_unit, :string
  end
end
