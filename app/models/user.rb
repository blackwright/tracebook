class User < ApplicationRecord

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :password, :length => { in: 8..24 },
                       :allow_nil => true


  def full_name
    "#{first_name} #{last_name}"
  end
  
end
