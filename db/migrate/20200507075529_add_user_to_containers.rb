class AddUserToContainers < ActiveRecord::Migration[6.0]
  def change
    add_reference :containers, :user, foreign_key: true
  end
end
