# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "MyString"
    description "MyText"
    street_address "MyString"
    extended_address "MyString"
    locality "MyString"
    region "MyString"
    postal_code "MyString"
    country "MyString"
  end
end
