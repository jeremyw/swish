module Dribbble
  class Shot < Base
    attr_accessor :id, :title, :url, :image_url, :image_teaser_url, :width, :height, :player,
        :views_count, :likes_count, :comments_count, :rebounds_count

    def after_initialize(attributes)
      @player = Dribbble::Player.new(attributes['player'])
    end

    def self.find(id)
      new(get("/shots/#{id}"))
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

    def self.paginated_list(result)
      PaginatedList.new(result, 'shots')
    end
  end
end
