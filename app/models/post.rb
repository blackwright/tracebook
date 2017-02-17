class Post < ApplicationRecord
  belongs_to :author, :class_name => "User",
                      :foreign_key => :user_id



  validates :body, :length => { minimum: 1 }
end
