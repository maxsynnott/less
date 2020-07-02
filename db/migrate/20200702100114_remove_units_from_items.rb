class RemoveUnitsFromItems < ActiveRecord::Migration[6.0]
  def change
  	remove_column :items, :units
  end
end
