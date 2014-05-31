# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    active false
    description "MyText"
    description_short "MyString"
    sold false
    location "MyString"
    reference "MyText"
    height "MyString"
    width "MyString"
    depth "MyString"
    diameter "MyString"
  end
end
