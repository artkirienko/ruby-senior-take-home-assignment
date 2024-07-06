RSpec.describe Vandelay::Integrations::Vendors::Two do
  describe '#patient_record' do
    it 'returns patient record data' do
      instance_two = described_class.new
      response_data = {
        "id" => 456,
        "province_code" => "BC",
        "allergies_list" => "None",
        "medical_visits_recently" => 3
      }

      expect(instance_two.patient_record(response_data)).to eq({
        "patient_id": 456,
        "province": "BC",
        "allergies": "None",
        "num_medical_visits": 3
      })
    end

    it 'returns empty hash for empty response data' do
      instance_two = described_class.new
      response_data = {}

      expect(instance_two.patient_record(response_data)).to eq({})
    end
  end
end
