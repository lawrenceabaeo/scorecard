# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fighter do
    first_name "Joe"
    last_name "Boxer"
    description "This is a description of the boxer"
    user nil
  end
end
