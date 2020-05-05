class RemoveSelectedFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :selected, :boolean
  end
end
