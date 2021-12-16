require 'swagger_helper'

RSpec.describe 'api/authentication', type: :request do
  path '/v1/register' do
    post 'Register a new User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          first_name: { type: :string },
          last_name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[email first_name last_name password password_confirmation]
      }

      response '200', 'User created' do
        let(:user) do
          { email: 'user@user.com', first_name: 'user', last_name: 'user', password: 'password',
            password_confirmation: 'password' }
        end
        run_test!
      end

      response '422', 'unprocessable entity' do
        let(:user) do
          { email: 'user@user.com', first_name: 'user', last_name: '', password: 'password',
            password_confirmation: 'password' }
        end
        run_test!
      end
    end
  end
end
