class Like < ApplicationRecord

  belongs_to :likeable, :polymorphic => true

  belongs_to :liker, :class_name => "User",
                     :foreign_key => :user_id
end
