RSpec.describe Vandelay::Integrations::Vendors::One do
  describe '#patient_record' do
    it 'returns patient record data' do
      instance_one = described_class.new
      response_data = {
        "id" => 123,
        "province" => "Ontario",
        "allergies" => "Peanuts",
        "recent_medical_visits" => 5
      }

      expect(instance_one.patient_record(response_data)).to eq({
        "patient_id": 123,
        "province": "Ontario",
        "allergies": "Peanuts",
        "num_medical_visits": 5
      })
    end

    it 'returns empty hash for empty response data' do
      instance_one = described_class.new
      response_data = {}

      expect(instance_one.patient_record(response_data)).to eq({})
    end
  end
end
