require 'swagger_helper'

RSpec.describe 'api/authentication', type: :request do
  let(:user1) { create(:user) }
  path '/v1/authenticate' do
    post 'Authenticate a User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '200', 'User authenticated' do
        let(:user) do 
          { email: user1.email, password: user1.password }
        end
        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) do 
          { email: 'user@user.com', password: 'password' }
        end
        run_test!
      end
    end
  end
end
