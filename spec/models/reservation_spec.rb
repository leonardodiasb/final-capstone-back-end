require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let!(:user) { create(:user) }
  let!(:restaurant) { create(:restaurant) }
  let!(:reservation) { create(:reservation, user_id: user.id, restaurant_id: restaurant.id) }

  it 'is a valid reservation' do
    expect(reservation).to be_valid
  end
end
