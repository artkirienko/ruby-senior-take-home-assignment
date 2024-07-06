module Vandelay
  module Integrations
    module Vendors
      class Two < Vandelay::Integrations::Vendors::Base
        def patient_record(response_data)
          return {} if response_data.empty?

          {
            "patient_id": response_data["id"],
            "province": response_data["province_code"],
            "allergies": response_data["allergies_list"],
            "num_medical_visits": response_data["medical_visits_recently"] 
          }
        end
      end
    end
  end
end
