module Dribbble
  class Shot < Base
    attr_reader :player
    def initialize(attributes={})
      @player = Dribbble::Player.new(attributes.delete('player')) if attributes['player']
      super
    end

    def self.find(id)
      new(query_api("/shots/#{id}"))
    end

    def comments(options={})
      paginated_list(query_api("/shots/#{@id}/comments", options))
    end

    # Options: :page, :per_page
    def self.debuts(options={})
      paginated_list(query_api("/shots/debuts", options))
    end

    # Options: :page, :per_page
    def self.everyone(options={})
      paginated_list(query_api("/shots/everyone", options))
    end

    # Options: :page, :per_page
    def self.popular(options={})
      paginated_list(query_api("/shots/popular", options))
    end
  end
end
