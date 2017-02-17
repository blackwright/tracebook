class Friending < ApplicationRecord

  belongs_to :friend_initiator, :class_name => "User",
                                :foreign_key => :friender_id
  belongs_to :friend_recipient, :class_name => "User",
                                :foreign_key => :friended_id



  validates :friended_id, :uniqueness => { :scope => :friender_id }
end
