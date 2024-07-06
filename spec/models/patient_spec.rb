require 'spec_helper'

RSpec.describe Vandelay::Models::Patient do
  describe '.all' do
    it 'returns an array of Patient objects' do
      # stub the connection to return some sample data
      conn = double('connection')
      allow(Vandelay::Models::Base).to receive(:with_connection) { |&block| block.call(conn) }
      allow(conn).to receive(:exec).with("SELECT * FROM patients ORDER BY id") { [{ id: 1, name: 'John' }, { id: 2, name: 'Jane' }] }

      patients = Vandelay::Models::Patient.all

      expect(patients).to be_an(Array)
      expect(patients.size).to eq(2)
      patients.each do |patient|
        expect(patient).to be_a(Vandelay::Models::Patient)
      end
    end
  end

  describe '.with_id' do
    it'returns a Patient object with the matching id' do
      # stub the connection to return some sample data
      conn = double('connection')
      allow(Vandelay::Models::Base).to receive(:with_connection) { |&block| block.call(conn) }
      allow(conn).to receive(:exec_params).with("SELECT * FROM patients WHERE id = $1::integer", [1]) { [{ id: 1, name: 'John' }] }

      patient = Vandelay::Models::Patient.with_id(1)

      expect(patient).to be_a(Vandelay::Models::Patient)
      expect(patient.id).to eq(1)
      expect(patient.name).to eq('John')
    end

    it'returns nil if no patient is found' do
      # stub the connection to return no data
      conn = double('connection')
      allow(Vandelay::Models::Base).to receive(:with_connection) { |&block| block.call(conn) }
      allow(conn).to receive(:exec_params).with("SELECT * FROM patients WHERE id = $1::integer", [1]) { nil }

      patient = Vandelay::Models::Patient.with_id(1)

      expect(patient).to be_nil
    end
  end
end
