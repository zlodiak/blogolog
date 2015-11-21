# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


all_users = []
all_posts = []
all_comments = []
all_tags = []
regular_users_quantity = 3
messages_quantity = 35
tags_quantity = 25

# user_statuses fill
UserStatus.create!(id: 1, title: 'active') 
UserStatus.create!(id: 2, title: 'blocked') 

# post_statuses fill
PostStatus.create!(id: 1, title: 'open') 
PostStatus.create!(id: 2, title: 'closed') 

# admin user
admin = User.create!(   
  title: "admin",
  email: "ad@ad.ad",
  password: 'qwertyui',
  password_confirmation: 'qwertyui', 
  user_status_id: 1,          
  superadmin: true
) 
all_users.push admin

# regular user
regular_users_quantity.times do |n|
  regular = User.create!(   
              title: Faker::Name.name,
              email: "us#{n+1}@ad.ad",
              password: 'qwertyui',
              user_status_id: 1,
              password_confirmation: 'qwertyui'
            ) 

  all_users.push regular
end

# messages
messages_quantity.times do |n|
  Message.create!(   
    anon_author_name: Faker::Name.name,
    email: Faker::Internet.email,
    title: Faker::Name.title,
    body: Faker::Lorem.paragraph(2) 
  ) 
end

# posts and root-comments
all_users.each do |user|
  user_post_quantity = rand(1..15)
  root_comments_quantity = rand(1..5)

  user_post_quantity.times do |n|
    post =  Post.create!(   
              title: Faker::Name.title,
              body: Faker::Lorem.paragraph(20),
              post_status_id: rand(1..2),
              user_id: user.id
            )   

    all_posts.push post    

    root_comments_quantity.times do |n|
      comment =  Comment.create!(   
                  body: Faker::Lorem.paragraph(5),
                  post_id: post.id,
                  user_id: rand(1..all_users.size)
                )  

      all_comments.push comment 
    end
  end
end

# tags
tags_quantity.times do |n|
  Tag.create!(   
    title: Faker::App.name
  ) 
end

# post and tags join table fill
all_posts.each do |post|
  tags_quantity_for_post = rand(0..tags_quantity)

  tags_quantity_for_post.times do |n|
    tag = Tag.find(n + 1)
    tag.posts << post
  end

end

# comment likes
all_comments.each do |comment|
  all_users.size.times do |user|
      comment_exis_flag = rand(0..3)

      if comment_exis_flag == 0
        CommentLike.create!(   
          comment_id: comment.id,
          user_id: User.find(user + 1).id
        )  
      end
  end
end

