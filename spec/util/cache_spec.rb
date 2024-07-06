require 'spec_helper'

RSpec.describe Vandelay::Util::Cache do
  describe "Cache" do
    describe '.default_expires_in' do
      it 'returns the default expires_in value from config' do
        expect(Vandelay::Util::Cache.default_expires_in).to eq Vandelay.config.dig("persistence", "redis", "expires_in")
      end
    end

    context  "when not expired" do
      before do
        Vandelay::Util::Cache.write('foo', 'bar', 5)
      end

      it "returns correct value" do
        expect(Vandelay::Util::Cache.read('foo')).to eq('bar')
      end
    end

    context  "when expired" do
      before do
        Vandelay::Util::Cache.write('foo', 'bar', 1)
        sleep 2
      end

      it "returns nil" do
        expect(Vandelay::Util::Cache.read('foo')).to eq(nil)
      end
    end
  end
end
