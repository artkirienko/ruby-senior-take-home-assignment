require 'redis'

module Vandelay
  module Util
    class Cache
      def self.default_expires_in
        expires_in = Vandelay.config.dig("persistence", "redis", "expires_in")
        expires_in ||= 10 * 60
        expires_in.to_i
      end

      def self.read(key)
        cached_data = Vandelay.redis.get(key)

        cached_data if cached_data
      end

      def self.write(key, data, expires_in = default_expires_in)
        Vandelay.redis.setex(key, expires_in, data)
      end
    end
  end
end
