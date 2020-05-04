class AddSelectedToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :selected, :boolean, default: false
  end
end
