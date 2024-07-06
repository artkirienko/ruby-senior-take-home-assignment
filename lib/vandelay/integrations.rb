Dir[File.dirname(__FILE__) + '/integrations/**/*.rb'].each {|rb| require_relative rb }

module Vandelay
  module Integrations
    # nothing to add here right now
  end
end
