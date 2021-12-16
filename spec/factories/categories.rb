FactoryBot.define do
  factory :category do
    name { Faker::Restaurant.type }
  end
end
