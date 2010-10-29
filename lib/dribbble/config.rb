module Dribbble
  module Config
    class << self
      attr_accessor :enable_redis, :expire_time
    end
  end
end
