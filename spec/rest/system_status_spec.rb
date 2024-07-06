require 'spec_helper'

include Rack::Test::Methods

describe Vandelay::REST::SystemStatus do
  describe 'GET /system_status' do
    it 'returns status OK and system time' do
      get '/system_status'

      expect(last_response.status).to eq(200)

      body = JSON.parse(last_response.body)
      expect(body['status']).to eq('OK')
      expect(body['system_time']).to match(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{2}:\d{2}/)
    end
  end
end
