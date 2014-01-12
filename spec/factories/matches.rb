# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
    redcorner nil
    bluecorner nil
    original_fight_date "2014-01-10 16:54:44"
    venue nil
    total_rounds 1
  end
end
