class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.attachment :image
      t.references :user, :null => false

      t.timestamps
    end
  end
end
