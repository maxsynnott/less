class CreateBillings < ActiveRecord::Migration[6.0]
  def change
    create_table :billings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.string :token
      t.integer :amount

      t.timestamps
    end
  end
end
