module Dribbble
  class PaginatedList < Array
    attr_reader :total, :pages, :per_page, :page
    def initialize(response, collection_type)
      @total = response['total']
      @pages = response['pages']
      @per_page = response['per_page']
      @page = response['page']
      collection_class = Dribbble.const_get(collection_type[0..-2].capitalize)
      super(response[collection_type].map { |attrs| collection_class.new attrs })
    end

    def inspect
      ivar_str = instance_variables.map {|iv| "#{iv}=#{instance_variable_get(iv).inspect}"}.join(", ")
      "#<#{self.class.inspect} #{ivar_str}, @contents=#{super}>"
    end
  end
end
