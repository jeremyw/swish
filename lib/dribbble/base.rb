module Dribbble
  class Base
    include HTTParty
    extend HTTParty

    base_uri 'api.dribbble.com'

    attr_accessor :created_at

    def initialize(attributes={})
      attributes ||= {}
      attributes.each do |key, value|
        setter = "#{key}="
        self.send setter, value if self.respond_to?(setter)
      end

      after_initialize(attributes)
    end

    def ==(other)
      other.equal?(self) || (other.instance_of?(self.class) && other.id == id)
    end

    # Delegates to ==
    def eql?(other)
      self == other
    end

    def created_at=(timestamp)
      @created_at = parse_time(timestamp)
    end

    protected

    def after_initialize(attributes)
      # no-op, can be overridden
    end

    def parse_time(time_string)
      Time.parse(time_string)
    end
  end
end
