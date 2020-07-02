class RenameBaseUnitToDefaultOnUnits < ActiveRecord::Migration[6.0]
  def change
  	rename_column :units, :base, :default
  end
end
