class CreateContainers < ActiveRecord::Migration[6.0]
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :size

      t.timestamps
    end
  end
end
