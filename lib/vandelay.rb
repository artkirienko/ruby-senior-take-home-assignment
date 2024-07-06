require 'yaml'

module Vandelay
  def self.service_name
    "Vandelay Industries"
  end

  def self.system_time_now
    Time.now
  end

  def self.config
    @config ||= YAML.load_file(self.config_path)
  end

  def self.env
    ENV['APP_ENV'] || 'dev'
  end

  def self.config_file_for_env
    "config.#{self.env}.yml"
  end

  def self.config_path
    @config_path ||= File.expand_path("../#{self.config_file_for_env}", File.dirname(__FILE__))
  end

  def self.redis
    @redis ||= ConnectionPool::Wrapper.new do
      Redis.new(url: Vandelay.config.dig("persistence", "redis", "redis_url"))
    end
  end
end
