class CreateFriendings < ActiveRecord::Migration[5.0]
  def change
    create_table :friendings do |t|
      t.references :friender, :references => :users, :null => false
      t.references :friended, :references => :users, :null => false

      t.timestamps
    end
  end
end
