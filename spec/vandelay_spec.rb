require 'spec_helper'

RSpec.describe Vandelay do
  describe '.service_name' do
    it 'returns Vandelay Industries' do
      expect(Vandelay.service_name).to eq('Vandelay Industries')
    end
  end

  describe '.system_time_now' do
    it 'returns the current time' do
      expect(Vandelay.system_time_now).to be_within(1).of(Time.now)
    end
  end

  describe '.env' do
    context 'when APP_ENV is set' do
      before { ENV['APP_ENV'] = 'test' }

      it 'returns the correct environment' do
        expect(Vandelay.env).to eq('test')
      end
    end

    context 'when APP_ENV is not set' do
      before { ENV.delete('APP_ENV') }

      it 'returns dev as default environment' do
        expect(Vandelay.env).to eq('dev')
      end
    end
  end

  describe '.config_file_for_env' do
    it 'returns the correct config file name based on environment' do
      expect(Vandelay.config_file_for_env).to eq('config.dev.yml')
    end
  end
end
