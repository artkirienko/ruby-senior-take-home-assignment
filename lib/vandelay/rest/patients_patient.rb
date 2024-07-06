require 'vandelay/services/patients'

module Vandelay
  module REST
    module PatientsPatient
      def self.patients_srvc
        @patients_srvc ||= Vandelay::Services::Patients.new
      end

      def self.registered(app)
        app.before '/patients/:id' do
          errors = []

          errors << 'Parameter "id" is required' unless params[:id]
          errors << 'Parameter "id" is not a number' unless params[:id] && params[:id].match?(/^\d+$/)

          halt 400, json(error: "Bad Request", message: "Invalid parameters: #{errors.join(', ')}" ) unless errors.empty?
        end

        app.get '/patients/:id' do
          result = Vandelay::REST::PatientsPatient.patients_srvc.retrieve_one(params[:id].to_i)
          if result
            json(result)
          else
            status 404
            json(error: 'Patient not found')
          end
        rescue StandardError => e
          status 500
          json(error: 'Internal server error', message: e.message)
        end
      end
    end
  end
end
