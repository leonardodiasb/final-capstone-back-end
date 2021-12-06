require 'swagger_helper'

RSpec.describe 'api/restaurants', type: :request do
  path '/v1/restaurants' do
    post 'Creates a new Restaurant' do
      tags 'Restaurants'
      consumes 'application/json'
      parameter name: :restaurant, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          reservation_spots: { type: :integer },
          image: { type: :string },
          price_range: { type: :integer }
        },
        required: %w[name description reservation_spots image price_range]
      }

      response '201', 'Restaurant created' do
        let(:restaurant) do
          { name: 'foo', description: 'bar', reservation_spots: 10, image: 'http://test.test', price_range: 3 }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:restaurant) { { name: 'Foo' } }
        run_test!
      end
    end
  end

  path '/v1/restaurants' do
    get 'Retrieves a list of Restaurants' do
      tags 'Restaurants'
      produces 'application/json'

      response '200', 'Restaurants found' do
        schema type: :array,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string },
                 reservation_spots: { type: :integer },
                 image: { type: :string },
                 price_range: { type: :integer }
               }
        run_test!
      end
    end
  end
end
