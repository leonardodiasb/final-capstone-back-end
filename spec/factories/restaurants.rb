FactoryBot.define do
  factory :restaurant do
    name { Faker::Fantasy::Tolkien.location }
    description { Faker::Lorem.sentence }
    image { Faker::Internet.url }
    reservation_spots { Faker::Number.number(digits: 2) }
    price_range { Faker::Number.within(range: 1..5) }
  end
end
