require 'swagger_helper'

RSpec.describe 'api/categories', type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { AuthenticateUser.call(user.email, user.password).result.to_s }
  let(:category) { create(:category) }
  path '/v1/categories' do
    get 'Retrieves a list of Categories' do
      tags 'Categories'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Categories found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string }
                 }
               }
        run_test!
      end
    end

    post "Create a new Category (if user is 'admin')" do
      tags 'Categories'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }
      response '200', 'Category created' do
        let(:category) do
          { name: 'foo' }
        end
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:category) { { name: '' } }
        run_test!
      end
    end
  end

  path '/v1/categories/{id}' do
    delete "Delete a Category (if user is 'admin')" do
      tags 'Categories'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'Category Deleted' do
        let(:id) { create(:category).id }
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               }
        run_test!
      end
    end
  end
end
