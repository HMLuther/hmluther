# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection do
    active false
    name "MyString"
    description "MyText"
    public false
  end
end
