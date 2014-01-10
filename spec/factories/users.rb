# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Colonel Williams"
    email "colonel@example.com"
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end
