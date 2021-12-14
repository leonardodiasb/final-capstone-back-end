require 'swagger_helper'

RSpec.describe 'api/restaurants', type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { AuthenticateUser.call(user.email, user.password).result.to_s }
  path '/v1/restaurants' do
    post "Create a new Restaurant (if user is 'admin')" do
      tags 'Restaurants'
      consumes 'application/json'
      # security [Bearer: []]
      # parameter name: :Authorization, :in => :header, :type => :string
      parameter name: :restaurant, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          reservation_spots: { type: :integer },
          image: { type: :string },
          price_range: { type: :integer },
          shifts: { type: :array, items: { type: :integer } },
          categories: { type: :array, items: { type: :integer } }
        },
        required: ['name', 'description', 'reservation_spots', 'image', 'price_range', 'shifts', 'categories']
      }
      response '201', 'Restaurant created' do
        let(:shift) { create(:shift) }
        let(:category) { create(:category) }
        let(:restaurant) do
          { name: 'foo', description: 'bar', reservation_spots: 10, image: 'http://test.test', price_range: 3,
            shifts: [shift.id], categories: [category.id] }
        end
        run_test!
      end

      response '400', 'bad request' do
        let(:shift) { create(:shift) }
        let(:category) { create(:category) }
        let(:restaurant) { { name: 'Foo', shifts: [shift.id], categories: [category.id] } }
        run_test!
      end
    end

    get 'Retrieves a list of Restaurants' do
      tags 'Restaurants'
      produces 'application/json'
      # security [Bearer: []]
      parameter name: :Authorization, :in => :header, :type => :string

      response '200', 'Restaurants found' do
        before { create(:restaurant) }
        schema type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  description: { type: :string },
                  reservation_spots: { type: :integer },
                  image: { type: :string },
                  price_range: { type: :integer },
                  shifts: { 
                    type: :array,
                    items: { 
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        name: { type: :string }
                      }
                    }
                  },
                  categories: { 
                    type: :array,items: { 
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        name: { type: :string }
                      }
                    }
                  }
                }
              }
        run_test!
      end
    end
  end

  path '/v1/restaurants/{id}' do
    delete "Delete a Restaurant (if user is 'admin')" do
      tags 'Restaurants'
      produces 'application/json'
      # security [Bearer: []]
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'Restaurant Deleted' do
        let(:id) { create(:restaurant).id }
        # schema type: :object,
        #       properties: {
        #         id: { type: :integer },
        #         name: { type: :string },
        #         description: { type: :string },
        #         reservation_spots: { type: :integer },
        #         image: { type: :string },
        #         price_range: { type: :integer },
        #         shifts: { 
        #           type: :array,
        #           items: { 
        #             type: :object,
        #             properties: {
        #               id: { type: :integer },
        #               name: { type: :string }
        #             }
        #           }
        #         },
        #         categories: { 
        #           type: :array,items: { 
        #             type: :object,
        #             properties: {
        #               id: { type: :integer },
        #               name: { type: :string }
        #             }
        #           }
        #         }
        #       }
        run_test!
      end
    end

    get 'Retrieve a Restaurant' do
      tags 'Restaurants'
      produces 'application/json'
      # security [Bearer: []]
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'Restaurant Found' do
        let(:id) { create(:restaurant).id }
        schema type: :object,
                properties: {
                  id: { type: :integer },
                  name: { type: :string },
                  description: { type: :string },
                  reservation_spots: { type: :integer },
                  image: { type: :string },
                  price_range: { type: :integer },
                  shifts: { 
                    type: :array,
                    items: { 
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        name: { type: :string }
                      }
                    }
                  },
                  categories: { 
                    type: :array,items: { 
                      type: :object,
                      properties: {
                        id: { type: :integer },
                        name: { type: :string }
                      }
                    }
                  }
                }
        run_test!
      end
    end
  end
end
