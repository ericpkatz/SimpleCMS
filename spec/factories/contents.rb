# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content do
    title Faker::Name.title 
    body Faker::Lorem.paragraph 
    page_id 3 
    priority 5
  end
end
