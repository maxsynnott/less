class AddContainerTypeToContainers < ActiveRecord::Migration[6.0]
  def change
    add_reference :containers, :container_type, null: false, foreign_key: true

    remove_column :containers, :name
    remove_column :containers, :size
    remove_column :containers, :price
  end
end
