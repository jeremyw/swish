module Dribbble
  class Base
    include HTTParty
    extend HTTParty

    base_uri 'api.dribbble.com'

    def initialize(attributes={})
      attributes ||= {}
      attributes.each do |key, value|
        instance_variable_set "@#{key}", value
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

    protected

    def after_initialize(attributes)
      # no-op, can be overridden
    end

    def self.paginated_list(result, list_key='shots')
      # result['total']
      # result['page']
      # result['pages']
      # result['per_page']
      result[list_key].map do |attributes|
        new(attributes)
      end
    end
  end
end
