class RenameStripIdToSessionIdOnBillings < ActiveRecord::Migration[6.0]
  def change
  	rename_column :billings, :stripe_id, :session_id
  end
end
