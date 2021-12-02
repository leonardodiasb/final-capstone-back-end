FactoryBot.define do
  factory :group do
    name { Faker::Fantasy::Tolkien.location }
    description { Faker::Lorem.sentence }
    image { Faker::Internet.url }
    reservation_spots { Faker::Number.within(range: 1..5) }
  end
end
