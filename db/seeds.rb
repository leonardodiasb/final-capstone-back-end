# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(
  first_name: 'admin',
	last_name: 'admin',
	email: 'admin1@user.com',
	password: 'password',
	password_confirmation: 'password',
	role:'admin'
)

restaurant1 = Restaurant.create(
  name: 'Restaurant 1',
  description: 'Japanese Restaurant',
  image: 'https://picsum.photos/200',
  reservation_spots: 20,
  price_range: 5
)

restaurant2 = Restaurant.create(
  name: 'Restaurant 2',
  description: 'Salad restaurant',
  image: 'https://picsum.photos/200',
  reservation_spots: 10,
  price_range: 2
)

restaurant3 = Restaurant.create(
  name: 'Restaurant 3',
  description: 'Burguer restaurant',
  image: 'https://picsum.photos/200',
  reservation_spots: 15,
  price_range: 3
)

japanese = Category.create(name: 'Japanese')
burguer = Category.create(name: 'Burguer')
salad = Category.create(name: 'Salad')

breakfast = Shift.create(name: 'Breakfast')
lunch = Shift.create(name: 'Lunch')
dinner = Shift.create(name: 'Dinner')

restaurant1.categories << japanese
restaurant2.categories << salad
restaurant3.categories << burguer

restaurant1.shifts << dinner
restaurant2.shifts << breakfast
restaurant2.shifts << lunch
restaurant3.shifts << lunch
restaurant3.shifts << dinner

reservation1 = Reservation.new(date: '2021-12-15',shift: 'Breakfast')

reservation1.restaurant_id = restaurant2.id
reservation1.user_id = user1.id
reservation1.save