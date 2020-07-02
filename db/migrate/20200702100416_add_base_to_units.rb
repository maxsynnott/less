class AddBaseToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :base, :boolean, default: false
  end
end
