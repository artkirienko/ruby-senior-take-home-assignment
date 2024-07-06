require 'net/http'

module Vandelay
  module Integrations
    module Vendors
      class Base
        def retrieve_record_for_patient(patient)
          path = "#{patient_records_endpoint}/#{patient.vendor_id}"
          patient_record(JSON.parse(get(path).body))
        end

        private

        def auth_token_endpoint
          Vandelay.config.dig("integrations", "vendors", "#{self.class.name.split('::').last.downcase}", "auth_token_endpoint")
        end

        def patient_records_endpoint
          Vandelay.config.dig("integrations", "vendors", "#{self.class.name.split('::').last.downcase}", "patient_records_endpoint")
        end

        def api_base_url
          Vandelay.config.dig("integrations", "vendors", "#{self.class.name.split('::').last.downcase}", "api_base_url")
        end

        def auth_token
          @auth_token ||= begin
            uri = URI("http://#{api_base_url}#{auth_token_endpoint}")
            response = Net::HTTP.get_response(uri)
            JSON.parse(response.body)['token']
          rescue => exception
            "can't get token"
          end
        end

        def get(path)
          uri = URI("http://#{api_base_url}#{path}")
          headers = {}
          headers.merge!({ 'Authorization' => "Bearer #{auth_token}" }) if auth_token
          http = Net::HTTP.new(uri.host, uri.port)
          response = http.get(uri.path, headers)
        end

        def patient_record(response_data)
          raise NotImplementedError, 'This method should be overridden in a subclass'
        end
      end
    end
  end
end
