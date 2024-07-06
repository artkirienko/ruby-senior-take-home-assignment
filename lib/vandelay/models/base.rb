require 'json'
require 'vandelay/util/db'

module Vandelay
  module Models
    class Base

      def initialize(**data)
        data.each do |prop, val|
          self.instance_variable_set "@#{prop}", val
          self.class.class_eval do
            define_method("#{prop}") { val }
          end
        end
      end

      def self.with_connection(&block)
        raise ArgumentError.new("Must provide a block to this method!") unless block_given?

        Vandelay::Util::DB.with_connection do |conn|
          yield(conn)
        end
      end

      def to_json(_opts = nil)
        JSON.dump(self.to_h)
      end

      def to_h
        self.attributes
      end

      def attributes
        self.instance_variables.map do |attribute|
          key = attribute.to_s.gsub('@', '')
          [key, self.instance_variable_get(attribute)]
        end.to_h
      end

    end
  end
end
