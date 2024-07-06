require 'spec_helper'

RSpec.describe Vandelay::REST::Patients do
  describe "GET all patients" do
    it "returns all patients" do
      get "/patients"
      expect(JSON.parse(last_response.body).size).to eq(3)
    end
  end
end
