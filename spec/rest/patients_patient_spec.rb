require 'spec_helper'

RSpec.describe Vandelay::REST::PatientsPatient do
  describe "GET single patient" do
    context  "invalid id" do
      it "returns all patients" do
          get "/patients/abc"
          expect(last_response.status).to eq(400)
      end
    end

    context  "patient does not exist" do
      it "returns patient not found" do
        get "/patients/4"
        expect(last_response.status).to eq(404)
      end
    end

    context  "patient exists" do
      it "returns  patient" do
        get "/patients/1"
        expect(JSON.parse(last_response.body)["full_name"]).to eq("Elaine Benes")
        expect(last_response.status).to eq(200)
      end
    end
  end
end
