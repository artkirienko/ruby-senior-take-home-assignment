require 'spec_helper'

RSpec.describe Vandelay::Services::Patients do
  let(:patients_service) { Vandelay::Services::Patients.new }

  describe '#retrieve_all' do
    it 'returns all patients' do
      patients = double('patients')
      allow(Vandelay::Models::Patient).to receive(:all).and_return(patients)

      expect(patients_service.retrieve_all).to eq(patients)
      expect(Vandelay::Models::Patient).to have_received(:all)
    end
  end

  describe '#retrieve_one' do
    let(:patient_id) { 1 }
    let(:patient) { double('patient') }

    it 'returns the patient with the specified id' do
      allow(Vandelay::Models::Patient).to receive(:with_id).with(patient_id).and_return(patient)

      expect(patients_service.retrieve_one(patient_id)).to eq(patient)
      expect(Vandelay::Models::Patient).to have_received(:with_id).with(patient_id)
    end
  end
end
