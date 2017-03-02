FactoryGirl.define do

  factory :user, :aliases => [:author] do
    first_name "Firstname"
    last_name  "Lastname"
    email      { "#{first_name}@email.com" }
    password   "password"
  end

  factory :profile do
    user

    trait :filled_out do
      birthday "11/10/1987"
      gender   "F"
      college  "Hofstra University"
      hometown "Great Neck"
      location "Marathon Parkway"
      phone    "123-456-7890"
      tagline  "Just Do It"
      about    "Just a small town girl"
    end
  end

  factory :post do
    body "Lorem ipsum dolor sit amet."
    author
  end

  factory :photo do
    author
  end

  factory :post_comment, :class => "Comment" do
    body "Lorem ipsum dolor sit amet."
    commentable_type "Post"
    association :commentable, :factory => :post
    author
  end

  factory :photo_comment, :class => "Comment" do
    body "Lorem ipsum dolor sit amet."
    commentable_type "Photo"
    association :commentable, :factory => :photo
    author
  end

  factory :post_like, :class => "Like" do
    likeable_type "Post"
    association :likeable, :factory => :post
    association :liker, :factory => :user
  end

  factory :photo_like, :class => "Like" do
    likeable_type "Photo"
    association :likeable, :factory => :photo
    association :liker, :factory => :user
  end

  factory :post_comment_like, :class => "Like" do
    likeable_type "Comment"
    association :likeable, :factory => :post_comment
    association :liker, :factory => :user
  end

  factory :photo_comment_like, :class => "Like" do
    likeable_type "Comment"
    association :likeable, :factory => :photo_comment
    association :liker, :factory => :user
  end
end
