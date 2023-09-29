FactoryBot.define do
  factory :reservation do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    image { Faker::LoremPixel.image }
    location { Faker::Address.city }
    price { Faker::Number.decimal(l_digits: 2) }
    duration { Faker::Number.number(digits: 2) }
    type { 'Reservation' }
    user_id { nil }
    trade_id { nil }
  end
end
