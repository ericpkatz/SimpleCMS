# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title Faker::Name.title
    body Faker::Lorem.paragraph
    priority 5
  end

  trait :home_page do
    is_home_page true
  end
  trait :low_priority do
    priority 1000
  end
  trait :high_priority do
    priority 1
  end
end
