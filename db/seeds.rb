print "Clearing database... "

Like.destroy_all
Comment.destroy_all
Post.destroy_all
Photo.destroy_all
Profile.destroy_all
Friending.destroy_all
User.destroy_all

puts "done!"

puts "Seeding database..."

MULTIPLIER = 10

puts "Seeding users..."
(MULTIPLIER * 2).times do |index|
  user = User.new(email: "user#{index + 1}@email.com",
                  password: "password",
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name)
  user.save!
end

puts "Seeding profiles..."
User.all.each do |u|
  u.profile.update(birthday: Faker::Date.between(40.years.ago, 18.years.ago),
                   college: Faker::Educator.university,
                   hometown: Faker::Address.city,
                   location: Faker::Address.street_name,
                   phone: Faker::PhoneNumber.cell_phone,
                   tagline: Faker::Lorem.paragraph,
                   about: Faker::Lorem.paragraph)
end

puts "Seeding posts..."
User.all.each do |user|
  MULTIPLIER.times do
    post = user.authored_posts.build(body: Faker::Lorem.paragraph(10),
                    created_at: Faker::Date.between(2.days.ago, Time.now))
    post.save!
  end
end

puts "Seeding comments..."
Post.all.each do |post|
  (rand 0..MULTIPLIER).times do
    comment = post.comments.build(user_id: User.pluck(:id).sample,
                                  body: Faker::Lorem.paragraph)
    comment.save!
  end
end

puts "Seeding friendships..."
User.all.each do |user|
  num_friends = rand(0..MULTIPLIER)
  all_friend_ids = User.where.not(:id => user.id).pluck(:id)
  until user.friended_users.count == num_friends
    new_friend = User.find_by_id(all_friend_ids.shuffle!.pop)
    user.friended_users << new_friend unless user.users_friended_by.include?(new_friend)
  end
end


puts "Seeding post likes..."
Post.all.each do |post|
  all_user_ids = User.pluck(:id)
  (rand 0..MULTIPLIER).times do
    like = post.likes.build(user_id: all_user_ids.shuffle!.pop)
    like.save!
  end
end

puts "Seeding comment likes..."
Comment.all.each do |comment|
  all_user_ids = User.pluck(:id)
  (rand 0..MULTIPLIER).times do
    like = comment.likes.build(user_id: all_user_ids.shuffle!.pop)
    like.save!
  end
end

puts "Seeding blank user..."
user = User.new(email: "user0@email.com",
                password: "password",
                first_name: "Blank",
                last_name: "User")
user.save!

puts "done!"
