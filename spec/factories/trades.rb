FactoryBot.define do
  factory :trade do
    name { "MyString" }
    description { "MyText" }
    image { "MyString" }
    location { "MyString" }
    price { "9.99" }
    duration { "MyString" }
    type { "" }
    user { nil }
  end
end
