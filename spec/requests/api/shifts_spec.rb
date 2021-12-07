require 'rails_helper'

RSpec.describe 'Shifts', type: :request do
  describe 'GET /v1/shifts' do
    it 'should get an unauthorized status' do
      get '/v1/shifts'
      expect(response).to have_http_status(401)
    end
  end
end
