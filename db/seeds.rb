# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
10.times do |_n|
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password')
end
10.times do |_n|
  u = User.all.sample
  u.posts.create(content: Faker::Lorem.paragraph)
end
100.times do |_n|
  p = Post.all.sample
  p.comments.create(content: Faker::Lorem.paragraph, user: User.all.sample)
end
10.times do |n|
  Follow.create(follower: User.all.sample, followee: User.all.sample)
end
10.times do |_n|
  FollowRequest.create(sender: User.all.sample, receiver: User.all.sample)
end
