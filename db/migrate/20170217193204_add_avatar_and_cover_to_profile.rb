class AddAvatarAndCoverToProfile < ActiveRecord::Migration[5.0]
  def change
    add_reference :profiles, :avatar, :references => :photos, :index => true
    add_foreign_key :profiles, :photos, :column => :avatar_id
    add_reference :profiles, :cover, :references => :photos, :index => true
    add_foreign_key :profiles, :photos, :column => :cover_id
  end
end
