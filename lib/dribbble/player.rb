module Dribbble
  class Player < Base
    def self.find(id)
      new(get("/players/#{id}"))
    end

    # Fetches this player's shots.
    # Options: :page, :per_page
    def shots(options={})
      paginated_list(self.class.get("/players/#{@id}/shots", :query => options))
    end

    # Fetches shots by players that this player follows.
    def shots_following(options={})
      paginated_list(self.class.get("/players/#{@id}/shots/following", :query => options))
    end

    def draftees(options={})
      paginated_list(self.class.get("/players/#{@id}/draftees", :query => options))
    end

    def followers(options={})
      paginated_list(self.class.get("/players/#{@id}/followers", :query => options))
    end

    def following(options={})
      paginated_list(self.class.get("/players/#{@id}/following", :query => options))
    end
  end
end
