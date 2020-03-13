# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count.zero?
  user = User.create!(email: 'admin@admin.com', first_name: 'admin', last_name: 'tester', phone_number: '0123456789',                         password: 'password', confirmed_at: Time.now)
  user.add_role :admin
  ap "create admin user => #{user.full_name}"
end
