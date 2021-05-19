# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Post.destroy_all

User.create!([{
  name: 'Admin',
  email:'Admin@gmail.com',
  password_digest: "$2a$12$udh8VoKni2jXZIC0WCASZOy/hcI39VC0V1Xi4xoYBwnkhXiaPfH9i", # BCrypt::Password.create("111111")
  profile: "Admin.jpg",
  role: 0,
  phone: "09766222245",
  address: "Yangon",
  dob: "2000-04-01",
  create_user_id: 1,
  updated_user_id: 1,
  deleted_user_id: "NULL",
  deleted_at: "NULL",
  created_at: Time.now,
  updated_at: Time.now,
  password_reset_token: "NULL",
  password_reset_sent_at: "NULL",
  auth_token: "NULL"
},
{
  name: 'User',
  email:'User@gmail.com',
  password_digest: "$2a$12$udh8VoKni2jXZIC0WCASZOy/hcI39VC0V1Xi4xoYBwnkhXiaPfH9i", # BCrypt::Password.create("111111")
  profile: "User.jpg",
  role: 1,
  phone: "09766222245",
  address: "Yangon",
  dob: "2000-04-01",
  create_user_id: 1,
  updated_user_id: 1,
  deleted_user_id: "NULL",
  deleted_at: "NULL",
  created_at: Time.now,
  updated_at: Time.now,
  password_reset_token: "NULL",
  password_reset_sent_at: "NULL",
  auth_token: "NULL"
}
])

Post.create!([{
  title: 'Novel',
  description:'Special Award Prize',
  status: 1,
  create_user_id: 1,
  updated_user_id: 1,
  deleted_user_id: "NULL",
  deleted_at: "NULL",
  created_at: Time.now,
  updated_at: Time.now,
},
{
  title: 'Travel',
  description:'Related With Short Trip',
  status: 0,
  create_user_id: 2,
  updated_user_id: 2,
  deleted_user_id: "NULL",
  deleted_at: "NULL",
  created_at: Time.now,
  updated_at: Time.now,
}
])