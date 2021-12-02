require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let!(:restaurant) { create(:restaurant) }

  it 'is a valid restaurant' do
    expect(restaurant).to be_valid
  end

  it 'has the correct attributes' do
    record = Restaurant.find(restaurant.id)
    expect(record.name).to eql(restaurant.name)
    expect(record.description).to eql(restaurant.description)
    expect(record.image).to eql(restaurant.image)
    expect(record.reservation_spots).to eql(restaurant.reservation_spots)
    expect(record.price_range).to eql(restaurant.price_range)
  end

  it 'is not valid when required attributes are nil' do
    restaurant.name = nil
    expect(restaurant).to_not be_valid
  end

  it 'is valid when description is nil' do
    restaurant.description = nil
    expect(restaurant).to be_valid
  end

  it 'is not valid when required attributes are nil' do
    restaurant.image = nil
    expect(restaurant).to_not be_valid
  end

  it 'is not valid when required attributes are nil' do
    restaurant.reservation_spots = nil
    expect(restaurant).to_not be_valid
  end

  it 'is not valid when required attributes are nil' do
    restaurant.price_range = nil
    expect(restaurant).to_not be_valid
  end

  it 'is not valid when price_range is not a valid number' do
    restaurant.price_range = 0
    expect(restaurant).to_not be_valid
    restaurant.price_range = 6
    expect(restaurant).to_not be_valid
    restaurant.price_range = 3
    expect(restaurant).to be_valid
  end

  it 'is not valid when reservation_spots is not a valid number' do
    restaurant.reservation_spots = 0
    expect(restaurant).to_not be_valid
    restaurant.reservation_spots = 3
    expect(restaurant).to be_valid
  end
end
