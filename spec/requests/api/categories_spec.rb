require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  describe 'GET /v1/categories' do
    it 'should get an unauthorized status' do
      get '/v1/categories'
      expect(response).to have_http_status(401)
    end
  end
end
