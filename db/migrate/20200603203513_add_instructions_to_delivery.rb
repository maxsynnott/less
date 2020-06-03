class AddInstructionsToDelivery < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :instructions, :text
  end
end
