class User < ApplicationRecord

  has_one :profile, :dependent => :destroy,
                    :inverse_of => :user
  has_many :authored_posts, -> { order "created_at desc" },
                            :dependent => :destroy,
                            :class_name => "Post",
                            :foreign_key => :user_id
  has_many :likes, :dependent => :destroy
  has_many :comments, :dependent => :destroy

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
  
end
