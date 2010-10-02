module Dribbble
  class Shot < Base
    def initialize(attributes={})
      super
      @attributes['player'] = Dribbble::Player.new(@attributes['player'])
    end

    def self.find(id)
      new(get("/shots/#{id}"))
    end

    def comments(options={})
      paginated_list(get("/shots/#{@id}/comments", :query => options))
    end

    # Options: :page, :per_page
    def self.debuts(options={})
      paginated_list(get("/shots/debuts", :query => options))
    end

    # Options: :page, :per_page
    def self.everyone(options={})
      paginated_list(get("/shots/everyone", :query => options))
    end

    # Options: :page, :per_page
    def self.popular(options={})
      paginated_list(get("/shots/popular", :query => options))
    end
  end
end
