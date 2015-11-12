# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create!(   
  email: "ad@ad.ad",
  password: 'qwertyui',
  password_confirmation: 'qwertyui', 
  superadmin: true
) 

3.times do |n|
  User.create!(   
    email: "us#{n+1}@ad.ad",
    password: 'qwertyui',
    password_confirmation: 'qwertyui'   
  ) 
end

