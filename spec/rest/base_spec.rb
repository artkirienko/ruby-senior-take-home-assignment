require 'spec_helper'

RSpec.describe Vandelay::REST::Base do
  include Rack::Test::Methods

  describe 'GET /' do
    it 'returns JSON with service_name' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to eq({ service_name: 'Vandelay Industries' }.to_json)
    end
  end
end
