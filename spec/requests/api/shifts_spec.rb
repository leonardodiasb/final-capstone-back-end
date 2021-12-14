require 'swagger_helper'

RSpec.describe 'api/shifts', type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { AuthenticateUser.call(user.email, user.password).result.to_s }
  let(:category) { create(:category) }
  path '/v1/shifts' do
    get 'Retrieves a list of Shifts' do
      tags 'Shifts'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'Shifts found' do
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

    post "Create a new Shift (if user is 'admin')" do
      tags 'Shifts'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :shift, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: ['name']
      }
      response '200', 'Shift created' do
        let(:shift) do
          { name: 'foo' }
        end
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:shift) { { name: '' } }
        run_test!
      end
    end
  end

  path '/v1/shifts/{id}' do
    delete "Delete a Shift (if user is 'admin')" do
      tags 'Shifts'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :integer

      response '200', 'Shift Deleted' do
        let(:id) { create(:shift).id }
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
