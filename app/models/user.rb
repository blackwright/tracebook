class User < ApplicationRecord

  has_one :profile, :dependent => :destroy,
                    :inverse_of => :user
  has_one :avatar, :through => :profile
  has_one :cover, :through => :profile

  has_many :authored_posts, -> { order "created_at desc" },
                            :dependent => :destroy,
                            :class_name => "Post",
                            :foreign_key => :user_id
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :initiated_friendings, :dependent => :destroy,
                                  :class_name => "Friending",
                                  :foreign_key => :friender_id
  has_many :friended_users, -> { where friendings: { accepted: true } },
                            :through => :initiated_friendings,
                            :source => :friend_recipient
  has_many :requested_users, -> { where friendings: { accepted: false } },
                             :through => :initiated_friendings,
                             :source => :friend_recipient

  has_many :received_friendings, :dependent => :destroy,
                                 :class_name => "Friending",
                                 :foreign_key => :friended_id
  has_many :users_friended_by, -> { where friendings: { accepted: true } },
                               :through => :received_friendings,
                               :source => :friend_initiator
  has_many :users_requested_by, -> { where friendings: { accepted: false } },
                                :through => :received_friendings,
                                :source => :friend_initiator

  has_many :photos, -> { order "created_at desc" },
                    :dependent => :destroy

  has_secure_password

  

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :password, :length => { in: 8..24 },
                       :allow_nil => true



  before_create :generate_token
  after_create :create_profile



  MISSING_AVATAR_URL = "https://s3.amazonaws.com/blackwright-tracebook/missing/medium/missing.png"
  MISSING_COVER_URL = "https://s3.amazonaws.com/blackwright-tracebook/missing/medium/missing.png"



  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def self.send_welcome_email(user_id)
    user = User.find_by_id(user_id)
    UserMailer.welcome(user).deliver
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friends_with?(user)
    friended_users.include?(user) || users_friended_by.include?(user)
  end

  def all_friends
    friended_users | users_friended_by
  end

  def pending_requests
    received_friendings.where(:accepted => false)
  end

  def destroy_friendship(ex_friend)
    friended_users.delete(ex_friend) &&
    ex_friend.friended_users.delete(self)
  end

  def side_friends
    result = []
    friends = all_friends
    num = friends.size < 6 ? friends.size : 6
    num.times { result << friends.shuffle!.pop }
    result
  end

  def side_photos
    photos.limit(6)
  end

  def self.search(query)
    where("first_name ILIKE ? OR last_name ILIKE ?",
          "#{query}%", "#{query}%") unless query.blank?
  end

  def feed_posts
    Post.includes(:author,
                  :likes => :liker,
                  :comments => [:author, :likes => :liker])
        .where(:user_id => self.all_friends.pluck(:id) << self.id)
        .order(:created_at => :desc)
        .limit(10)
  end

  def avatar_url
    if avatar
      avatar.image.url(:medium)
    else
      MISSING_AVATAR_URL
    end
  end

  def cover_url
    if cover
      cover.image.url
    else
      MISSING_COVER_URL
    end
  end
end
