module Dribbble
  class Base
    include HTTParty
    extend HTTParty

    base_uri 'api.dribbble.com'

    def initialize(attributes=nil)
      @attributes = attributes || {}
      @attributes.each_key { |k| instance_eval "undef #{k} if __respond_to__?(:#{k})" }
      @attributes['created_at'] = parse_time(@attributes['created_at'])
    end

    alias __respond_to__? respond_to?
    def respond_to?(method)
      @attributes.has_key?(method.to_s) || __respond_to__?(method)
    end

    def method_missing(method, *args, &block)
      if @attributes.has_key?(method.to_s)
        @attributes[method.to_s]
      else
        super
      end
    end

    def ==(other)
      other.equal?(self) || (other.instance_of?(self.class) && other.id == id)
    end

    # Delegates to ==
    def eql?(other)
      self == other
    end

    def self.paginated_list(results)
      Dribbble::PaginatedList.new(results)
    end

    def paginated_list(results)
      self.class.paginated_list(results)
    end

    protected

    def parse_time(time_string)
      Time.parse(time_string) if time_string
    end
  end
end
