RSpec.describe Vandelay::Integrations::Vendors::One do
  describe '#auth_token' do
    it 'returns token from API response' do
      base_instance = described_class.new
      allow(base_instance).to receive(:api_base_url).and_return('example.com')
      allow(base_instance).to receive(:auth_token_endpoint).and_return('/auth/token')
      allow(Net::HTTP).to receive(:get_response).and_return(double(body: '{"token": "test_token"}'))

      expect(base_instance.send(:auth_token)).to eq('test_token')
    end

    it 'handles exceptions gracefully' do
      base_instance = described_class.new
      allow(base_instance).to receive(:api_base_url).and_return('example.com')
      allow(base_instance).to receive(:auth_token_endpoint).and_return('/auth/token')
      allow(Net::HTTP).to receive(:get_response).and_raise(StandardError.new('Failed to get response'))

      expect(base_instance.send(:auth_token)).to eq("can't get token")
    end
  end
end
