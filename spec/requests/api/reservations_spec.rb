require 'swagger_helper'

RSpec.describe 'api/reservations', type: :request do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant) }
  let(:Authorization) { AuthenticateUser.call(user.email, user.password).result.to_s }
  path '/v1/reservations' do
    post 'Create a new Reservation' do
      tags 'Reservations'
      consumes 'application/json'
      # security [Bearer: []]
      # parameter name: :auth_token, :in => :header, :type => :string
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string },
          shift: { type: :string },
          user_id: { type: :integer },
          restaurant_id: { type: :integer }
        },
        required: %w[date shift user_id restaurant_id]
      }
      response '200', 'Reservation created' do
        let(:reservation) do
          { date: '2020-10-10', shift: 'Dinner', user_id: user.id, restaurant_id: restaurant.id }
        end
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:reservation) do
          { date: '2000', shift: '', user_id: user.id, restaurant_id: restaurant.id }
        end
        run_test!
      end
    end

    get 'Retrieves a list of Reservations' do
      tags 'Reservations'
      produces 'application/json'
      # security [Bearer: []]

      response '200', 'Reservations found' do
        let(:reservation) do
          { date: '2020-10-10', shift: 'Dinner', user_id: user.id, restaurant_id: restaurant.id }
        end
        let(:id) { :reservation.id }
        schema type: :array,
               items: { type: :object,
                        properties: { date: { type: :string }, shift: { type: :string }, user_id: { type: :integer },
                                      restaurant_id: { type: :integer } } }
        run_test!
      end
    end
  end

  path '/v1/reservations/{id}' do
    delete 'Delete a Reservation' do
      tags 'Reservations'
      produces 'application/json'
      # security [Bearer: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'Reservation Deleted' do
        let(:reservation) { create(:reservation, user_id: user.id, restaurant_id: restaurant.id) }
        let(:id) { reservation.id }
        schema type: :object,
               properties: {
                 date: { type: :string },
                 shift: { type: :string },
                 user_id: { type: :integer },
                 restaurant_id: { type: :integer }
               }
        run_test!
      end
    end
  end
end
