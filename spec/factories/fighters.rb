# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fighter do
    first_name "MyString"
    last_name "MyString"
    description "MyText"
    user nil
  end
end
