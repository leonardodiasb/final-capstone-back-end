FactoryBot.define do
  factory :shift do
    name { Faker::Restaurant.type }
  end
end
