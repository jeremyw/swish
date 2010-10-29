module Dribbble
  module Config
    class << self
      attr_accessor :enable_redis, :expire_time, :redis_host, :redis_port, :redis_password
    end
  end
end
