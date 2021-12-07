require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  describe 'GET /v1/reservations' do
    it 'should get an unauthorized status' do
      get '/v1/reservations'
      expect(response).to have_http_status(401)
    end
  end
end
