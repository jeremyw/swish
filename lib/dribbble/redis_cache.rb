module Dribbble
  class RedisCache
    require 'redis' if Dribbble::Config.enable_redis

    include HTTParty
    base_uri 'api.dribbble.com'

    def self.fetch(path, options)
      if Dribbble::Config.enable_redis
        redis = Redis.new
        redis_key = "#{path}::#{options.hash}"
        cached_val = redis.get(redis_key)
        if cached_val
          JSON.parse cached_val
        else
          live_val = get(path, :query => options).parsed_response
          redis.set redis_key, live_val.to_json
          redis.expire redis_key, 60
          live_val
        end
      else
        get(path, :query => options)
      end
    end
  end
end
