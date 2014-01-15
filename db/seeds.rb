# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
# puts 'DEFAULT USERS'
# user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
# puts 'user: ' << user.name
# user.confirm!

admin = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
admin.skip_confirmation!
admin.save

u = User.new(
  name: 'System Default',
  email: 'systemdefault@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

fighter_a = Fighter.new(:first_name => "Fighter", :last_name => "A", :user => u)
fighter_a.save

fighter_b = Fighter.new(:first_name => "Fighter", :last_name => "B", :user => u)
fighter_b.save

