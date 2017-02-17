class AddForeignKeysToFriendings < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :friendings, :users, :column => :friender_id
    add_foreign_key :friendings, :users, :column => :friended_id
  end
end
