class Profile < ApplicationRecord
  belongs_to :user, :inverse_of => :profile
  belongs_to :avatar, :class_name => "Photo",
                      :optional => true
  belongs_to :cover, :class_name => "Photo",
                     :optional => true
end
