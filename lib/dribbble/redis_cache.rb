module Dribbble
  class RedisCache
    include HTTParty
    base_uri 'api.dribbble.com'

    attr_reader :value

    def self.fetch(path, options)
      new(path, options).value
    end

    def initialize(path, options)
      @path = path
      @options = options

      if Dribbble::Config.enable_redis
        @connection = Redis.new(redis_config)
        @key = "#{path}::#{options.hash}"
        @value = cached_value
      else
        @value = api_response
      end 
    end

    def cached_value
      JSON.parse(@connection.get(@key) || cache_response)
    end

    def api_response
      self.class.get @path, :query => @options
    end

    private 

    def redis_config
      { :host => Dribbble::Config.redis_host || "localhost",
        :port => Dribbble::Config.redis_port || 6379,
        :password => Dribbble::Config.redis_password }
    end

    def expire_time
      @expire_time ||= (Dribbble::Config.expire_time || 60)
    end

    def cache_response
      live_value = api_response.to_json
      @connection.set @key, live_value
      @connection.expire @key, expire_time
      live_value
    end
  end
end

#TODO: Add an api-hits-this-minute key, expires in 60". Pad cap down to 55.
#      If value is > 55, put requests on queue, sleep key's TTL
