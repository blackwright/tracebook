FactoryGirl.define do

  factory :user, :aliases => [:author] do
    first_name "Firstname"
    last_name  "Lastname"
    email      { "#{first_name}@email.com" }
    password   "password"
  end

  factory :post do
    body "Lorem ipsum dolor sit amet."
    author
  end

  factory :comment do
    body "Lorem ipsum dolor sit amet."
    author

    trait :for_post do
      commentable_type "Post"
      association :commentable, :factory => :post
    end

    trait :for_photo do
      commentable_type "Photo"
      association :commentable, :factory => :photo
    end
  end

end
