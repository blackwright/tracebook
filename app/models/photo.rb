require 'open-uri'

class Photo < ApplicationRecord

  belongs_to :author, :class_name => "User",
                      :foreign_key => :user_id

  has_attached_file :image, :styles => { medium: "300x300", thumb: "100x100" },
                            :default_url => "https://s3.amazonaws.com/blackwright-danebook/missing/:style/missing.png"

  has_many :likes, :dependent => :destroy,
                   :as => :likeable
  has_many :likers, :through => :likes

  has_many :comments, -> { order "created_at desc"},
                      :dependent => :destroy,
                      :as => :commentable

  

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/



  def image_from_url(url)
    self.image = open(url)
  end
end
