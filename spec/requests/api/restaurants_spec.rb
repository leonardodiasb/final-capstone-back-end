require 'swagger_helper'

RSpec.describe 'api/restaurants', type: :request do
  path '/v1/restaurants' do
    post 'Creates a new Restaurant' do
      tags 'Restaurants'
      consumes 'application/json'
      security [Bearer: {}]
      parameter name: :restaurant, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          reservation_spots: { type: :integer },
          image: { type: :string },
          price_range: { type: :integer },
          shifts: { type: :array },
          categories: { type: :array }
        },
        required: %w[name description reservation_spots image price_range shifts categories]
      }

      response '201', 'Restaurant created' do
        let(:shift) { create(:shift) }
        let(:category) { create(:category) }
        let(:user) { create(:user) }
        let(:"Authorization") { "#{AuthenticateUser.call(user.email, user.password).result}" }
        let(:restaurant) { { name: 'foo', description: 'bar', reservation_spots: 10, image: 'http://test.test', price_range: 3, shifts: [shift.id], categories: [category.id] } }
        run_test!
      end

      response '400', 'bad request' do
        let(:shift) { create(:shift) }
        let(:category) { create(:category) }
        let(:user) { create(:user) }
        let(:"Authorization") { "#{AuthenticateUser.call(user.email, user.password).result}" }
        let(:restaurant) { { name: 'Foo', shifts: [shift.id], categories: [category.id] } }
        run_test!
      end
    end
  end

  path '/v1/restaurants' do
    get 'Retrieves a list of Restaurants' do
      tags 'Restaurants'
      produces 'application/json'
      security [Bearer: {}]

      response '200', 'Restaurants found' do
        let(:user) { create(:user) }
        let(:"Authorization") { "#{AuthenticateUser.call(user.email, user.password).result}" }
        schema type: :array,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            reservation_spots: { type: :integer },
            image: { type: :string },
            price_range: { type: :integer },
            shifts: { type: :array },
            categories: { type: :array }
          }
        run_test!
      end
    end
  end
end
