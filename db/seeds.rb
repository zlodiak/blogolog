# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


all_users = []

# user_statuses fill
UserStatus.create!(id: 1, title: 'active') 
UserStatus.create!(id: 2, title: 'blocked') 

# post_statuses fill
PostStatus.create!(id: 1, title: 'open') 
PostStatus.create!(id: 2, title: 'closed') 

# admin user
admin = User.create!(   
          email: "ad@ad.ad",
          password: 'qwertyui',
          password_confirmation: 'qwertyui', 
          user_status_id: 1,          
          superadmin: true
        ) 
all_users.push admin

# regular user
users_quantity = 3

users_quantity.times do |n|
  regular = User.create!(   
              email: "us#{n+1}@ad.ad",
              password: 'qwertyui',
              user_status_id: 1,
              password_confirmation: 'qwertyui'
            ) 

  all_users.push regular
end

# messages
messages_quantity = 35

messages_quantity.times do |n|
  Message.create!(   
    anon_author_name: Faker::Name.name,
    email: Faker::Internet.email,
    title: Faker::Name.title,
    body: Faker::Lorem.paragraph(2) 
  ) 
end

# posts
all_users.each do |user|
  user_post_quantity = rand(1..15)

  user_post_quantity.times do |n|
    Post.create!(   
      title: Faker::Name.title,
      body: Faker::Lorem.paragraph(20),
      post_status_id: rand(1..2),
      user_id: user.id
    )   
  end
end

