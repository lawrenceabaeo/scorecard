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

yaml_system_user = YAML_CONFIG["yaml_system_user"]
if (User.where(:name => yaml_system_user["name"]).where(:email => yaml_system_user["email"]).exists? == false)
  sys_user = User.new(yaml_system_user)
  sys_user.skip_confirmation!
  sys_user.save
else 
  sys_user = User.find_by_email(yaml_system_user["email"])
end

fighter_a = YAML_CONFIG["fighter_a"]
if (Fighter.where(:first_name => fighter_a["first_name"]).where(:last_name => fighter_a["last_name"]).where(:user_id => sys_user).exists? == false)
  sys_user.fighters.create(fighter_a)
end

fighter_b = YAML_CONFIG["fighter_b"]
if (Fighter.where(:first_name => fighter_b["first_name"]).where(:last_name => fighter_b["last_name"]).where(:user_id => sys_user).exists? == false)
  sys_user.fighters.create(fighter_b)
end
