FactoryBot.define do
  factory :user do
    first_name { Faker::Movies::StarWars.character.split.first }
    last_name { Faker::Movies::StarWars.character.split.last }
    email { "#{first_name}@starwars.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'admin' }
  end
end
