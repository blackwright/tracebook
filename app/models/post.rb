class Post < ApplicationRecord
  belongs_to :author, :class_name => "User",
                      :foreign_key => :user_id
  has_many :likes, :dependent => :destroy,
                   :as => :likeable
  has_many :likers, :through => :likes



  validates :body, :length => { minimum: 1 }
end
