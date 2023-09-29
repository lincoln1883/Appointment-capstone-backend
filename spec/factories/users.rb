FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    role { 'user' }
  end
end
