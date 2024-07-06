require 'spec_helper'

RSpec.describe Vandelay::Util::DB::Connection do
  let(:pg_url) { Vandelay.config.dig("persistence", "pg_url") }  # Replace with your test database URL

  before do
    allow(Vandelay.config).to receive(:dig).with('persistence', 'pg_url').and_return(pg_url)
  end

  describe '#initialize' do
    it 'should initialize PG connection with correct db_url' do
      connection = described_class.new
      expect(connection.instance_variable_get(:@conn).db).to eq('vandelay')
    end
  end
end

RSpec.describe Vandelay::Util::DB do
  describe '.with_connection' do
    let(:pg_url) { Vandelay.config.dig("persistence", "pg_url") }  # Replace with your test database URL

    before do
      allow(Vandelay.config).to receive(:dig).with('persistence', 'pg_url').and_return(pg_url)
    end

    it 'should yield to the block with a connection and return the block result' do
      result = described_class.with_connection do |conn|
        conn.exec("SELECT * FROM patients")
      end
      expect(result).to be_truthy
    end

    it 'should raise ArgumentError if no block is given' do
      expect { described_class.with_connection }.to raise_error(ArgumentError, "block must be given!")
    end
  end
end
