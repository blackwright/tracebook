class User < ApplicationRecord

  has_one :profile, :dependent => :destroy,
                    :inverse_of => :user
  has_many :authored_posts, -> { order "created_at desc" },
                            :dependent => :destroy,
                            :class_name => "Post",
                            :foreign_key => :user_id
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :initiated_friendings, :dependent => :destroy,
                                  :class_name => "Friending",
                                  :foreign_key => :friender_id
  has_many :friended_users, :through => :initiated_friendings,
                            :source => :friend_recipient
  has_many :received_friendings, :dependent => :destroy,
                                 :class_name => "Friending",
                                 :foreign_key => :friended_id
  has_many :users_friended_by, :through => :received_friendings,
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

  def full_name
    "#{first_name} #{last_name}"
  end

  def destroy_friendship(ex_friend)
    friended_users.delete(ex_friend) &&
    ex_friend.friended_users.delete(self)
  end

  def friends?(user)
    friended_users.include?(user) || users_friended_by.include?(user)
  end

  def all_friends
    friended_users + users_friended_by
  end

  def side_friends
    result = []
    friends = all_friends
    num = friends.size < 6 ? friends.size : 6
    num.times { result << friends.shuffle!.pop }
    result
  end
  
end
