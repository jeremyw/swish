module Dribbble
  class PaginatedList < Array
    attr_reader :total, :pages, :per_page, :page
    def initialize(response)
      @total = response['total']
      @pages = response['pages']
      @per_page = response['per_page']
      @page = response['page']

      result_key, result_class = response.has_key?('shots') \
        ? ['shots', Dribbble::Shot] \
        : ['players', Dribbble::Player]

      super(response[result_key].map { |attrs| result_class.new attrs })
    end

    def inspect
      ivar_str = instance_variables.map {|iv| "#{iv}=#{instance_variable_get(iv).inspect}"}.join(", ")
      "#<#{self.class.inspect} #{ivar_str}, @contents=#{super}>"
    end
  end
end
