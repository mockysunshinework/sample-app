# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin:true)
              
99.times do |n|
  name = Faker::Name.name
  email = "sample-#{n + 1}@email.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end


admin_user = User.first
guest_user_1 = User.find(2)
guest_user_2 = User.find(3)


50.times do |n|
  name = "タスク#{n + 1}"
  description = "詳細#{n + 1}でございます！"

  admin_user.tasks.create!(name: name, description: description)
  guest_user_1.tasks.create!(name: name, description: description)
  guest_user_2.tasks.create!(name: name, description: description)
end
            