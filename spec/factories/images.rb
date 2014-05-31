# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    active false
    banner false
    comp false
    thumb false
    image_type "MyString"
    url "MyString"
  end
end
