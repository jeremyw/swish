module Dribbble
  class Player < Base
    def self.find(id)
      new(query_api("/players/#{id}"))
    end

    # Fetches this player's shots.
    # Options: :page, :per_page
    def shots(options={})
      paginated_list(query_api("/players/#{@id}/shots", options))
    end

    # Fetches shots by players that this player follows.
    def shots_following(options={})
      paginated_list(query_api("/players/#{@id}/shots/following", options))
    end

    def draftees(options={})
      paginated_list(query_api("/players/#{@id}/draftees", options))
    end

    def followers(options={})
      paginated_list(query_api("/players/#{@id}/followers", options))
    end

    def following(options={})
      paginated_list(query_api("/players/#{@id}/following", options))
    end
  end
end
