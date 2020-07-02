class RenameItemContainers < ActiveRecord::Migration[6.0]
  def change
  	rename_table :item_containers, :item_container_types

  	rename_column :item_container_types, :container_id, :container_type_id
  end
end
