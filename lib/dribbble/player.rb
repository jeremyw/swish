module Dribbble
  class Player < Base
    attr_accessor :id, :name, :url, :avatar_url, :location

    def self.find(id)
      new(get("/players/#{id}"))
    end

    # Fetches this player's shots.
    # Options: :page, :per_page
    def shots(options={})
      Shot.paginated_list(self.class.get("/players/#{@id}/shots", :query => options))
    end

    # Fetches shots by players that this player follows.
    def shots_following(options={})
      Shot.paginated_list(self.class.get("/players/#{@id}/shots/following", :query => options))
    end
  end
end