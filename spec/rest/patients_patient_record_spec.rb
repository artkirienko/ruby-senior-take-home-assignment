require 'spec_helper'

RSpec.describe Vandelay::REST::PatientsPatientRecord do
  describe "GET single patient record" do
    context  "invalid id" do
      it "returns all patients" do
        get "/patients/abc/record"
        expect(last_response.status).to eq(400)
      end
    end

    context  "patient does not exist" do
      it "returns patient not found" do
        get "/patients/4/record"
        expect(last_response.status).to eq(404)
      end
    end

    context  "patient exists but not record" do
      it "returns  no record found" do
        get "/patients/1/record"
        expect(last_response.status).to eq(404)
      end
    end

    context  "patient exists but with record" do
      it "returns correct record" do
        get "/patients/2/record"
        expect(JSON.parse(last_response.body)['patient_id']).to eq('743')
        expect(last_response.status).to eq(200)
      end
    end
  end
end
