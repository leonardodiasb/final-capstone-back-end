FactoryBot.define do
  factory :reservation do
    date { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    shift { 'Dinner' }
    user_id { Faker::Number.number(digits: 2) }
    restaurant_id { Faker::Number.number(digits: 2) }
  end
end
