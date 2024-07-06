require 'spec_helper'

describe Vandelay::Models::Base do
  let(:data) { { name: 'John', age: 30 } }
  let(:model) { Vandelay::Models::Base.new(**data) }

  describe '#initialize' do
    it 'sets instance variables' do
      expect(model.instance_variable_get('@name')).to eq('John')
      expect(model.instance_variable_get('@age')).to eq(30)
    end

    it 'defines methods for each property' do
      expect(model.respond_to?(:name)).to be true
      expect(model.respond_to?(:age)).to be true
    end
  end

  describe '.with_connection' do
    it 'raises an error if no block is provided' do
      expect { Vandelay::Models::Base.with_connection }.to raise_error(ArgumentError)
    end

    it 'yields the connection to the block' do
      conn = double('connection')
      allow(Vandelay::Util::DB).to receive(:with_connection) { |&block| block.call(conn) }
      expect { |b| Vandelay::Models::Base.with_connection(&b) }.to yield_with_args(conn)
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the model' do
      expect(model.to_json).to eq('{"name":"John","age":30}')
    end
  end

  describe '#to_h' do
    it 'returns a hash representation of the model' do
      expect(model.to_h).to eq({ 'name' => 'John', 'age' => 30 })
    end
  end

  describe '#attributes' do
    it 'returns a hash of instance variables' do
      expect(model.attributes).to eq({ 'name' => 'John', 'age' => 30 })
    end
  end
end
