module Vandelay
  module Services
    class PatientRecords
      def retrieve_record_for_patient(patient)
        return nil if patient.records_vendor.nil? || patient.vendor_id.nil?

        vendor = vendor_class(patient.records_vendor)
        return nil unless vendor

        cached = Vandelay::Util::Cache.read("#{patient.records_vendor}:#{patient.vendor_id}")

        return JSON.parse(cached) if cached

        patient_record = vendor.new.retrieve_record_for_patient(patient)

        Vandelay::Util::Cache.write("#{patient.records_vendor}:#{patient.vendor_id}", JSON(patient_record), 10 * 60)

        patient_record
      end

      def vendor_class(records_vendor)
        class_name = "Vandelay::Integrations::Vendors::#{records_vendor.capitalize}"
        if Object.const_defined?(class_name)
          klass = Object.const_get(class_name)
          return klass if klass.is_a?(Class)
        end
        nil
      end
    end
  end
end
