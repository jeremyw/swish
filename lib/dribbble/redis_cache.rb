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
        @connection = Redis.new
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

    def cache_response
      live_value = api_response.to_json
      @connection.set @key, live_value
      @connection.expire @key, 60
      live_value
    end
  end
end

#TODO: Add an api-hits-this-minute key, expires in 60". Pad cap down to 55.
#      If value is > 55, put requests on queue, sleep key's TTL
