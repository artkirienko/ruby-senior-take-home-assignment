module Vandelay
  module Integrations
    module Vendors
      class One < Vandelay::Integrations::Vendors::Base
        def patient_record(response_data)
          return {} if response_data.empty?

          {
            "patient_id": response_data["id"],
            "province": response_data["province"],
            "allergies": response_data["allergies"],
            "num_medical_visits": response_data["recent_medical_visits"] 
          }
        end
      end
    end
  end
end
