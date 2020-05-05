class RemoveColumnNotesFromAddresses < ActiveRecord::Migration[6.0]
  def change
  	remove_column :addresses, :notes, :text
  end
end
