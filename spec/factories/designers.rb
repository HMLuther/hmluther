# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :designer do
    name "MyString"
    bio "MyString"
    active false
    include false
    omit false
    production_date "MyString"
    website "MyString"
    filemaker_id 1
  end
end
