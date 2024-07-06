require 'net/http'
require 'vandelay/services/patients'
require 'vandelay/services/patient_records'

module Vandelay
  module REST
    module PatientsPatientRecord
      def self.patients_srvc
        @patients_srvc ||= Vandelay::Services::Patients.new
      end

      def self.patient_records_srvc
        @patient_records_srvc ||= Vandelay::Services::PatientRecords.new
      end

      def self.registered(app)
        app.before '/patients/:patient_id/record' do
          errors = []

          errors << 'Parameter "patient_id" is required' unless params[:patient_id]
          errors << 'Parameter "patient_id" is not a number' unless params[:patient_id] && params[:patient_id].match?(/^\d+$/)

          halt 400, json(error: "Bad Request", message: "Invalid parameters: #{errors.join(', ')}" ) unless errors.empty?
        end

        app.get '/patients/:patient_id/record' do
          patient = Vandelay::REST::PatientsPatient.patients_srvc.retrieve_one(params[:patient_id].to_i)
          unless patient
            status 404
            return json(error: 'Patient not found')
          end

          result = Vandelay::REST::PatientsPatientRecord.patient_records_srvc.retrieve_record_for_patient(patient)
          if result
            json(result)
          else
            status 404
            json(error: 'Patient Record not found')
          end
        rescue StandardError => e
          status 500
          json(error: 'Internal server error', message: e.message)
        end
      end
    end
  end
end
