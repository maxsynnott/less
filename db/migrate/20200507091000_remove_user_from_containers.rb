class RemoveUserFromContainers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :containers, :user, null: false, foreign_key: true
  end
end
