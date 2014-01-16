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

setup_data_file  = File.join(Rails.root, 'db', 'system_objects.yml')
yaml_data = YAML::load_file(setup_data_file)

if (User.where(:name => "System Default").where(:email => "systemdefault@example.com").exists? == false)
  system_user = User.new(yaml_data["system_user"])
  system_user.skip_confirmation!
  system_user.save
else 
  system_user = User.find_by_email("systemdefault@example.com")
end

if (Fighter.where(:first_name => "Fighter").where(:last_name => "A").where(:user_id => system_user).exists? == false)
  fighter_a = Fighter.create(yaml_data["fighter_a"])
  fighter_a.update_attributes(:user => system_user)
end

if (Fighter.where(:first_name => "Fighter").where(:last_name => "B").where(:user_id => system_user).exists? == false)
  fighter_b = Fighter.create(yaml_data["fighter_b"])
  fighter_b.update_attributes(:user => system_user)
end
