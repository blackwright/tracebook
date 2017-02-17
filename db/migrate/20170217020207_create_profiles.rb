class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, :foreign_key => true, :null => false
      t.date :birthday
      t.string :gender
      t.string :college
      t.string :hometown
      t.string :location
      t.string :phone
      t.text :tagline
      t.text :about
      
      t.timestamps
    end
  end
end
