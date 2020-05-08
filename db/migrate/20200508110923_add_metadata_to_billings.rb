class AddMetadataToBillings < ActiveRecord::Migration[6.0]
  def change
    add_column :billings, :metadata, :string
  end
end
