class AddUniqueKeyToContainers < ActiveRecord::Migration[6.0]
  def change
    add_column :containers, :unique_key, :string
  end
end
