FactoryBot.define do
  factory :reservation do
    date { Date.today }
    user { association :user }
    trade { association :trade }
  end
end
