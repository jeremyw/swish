module Dribbble
  class Player < Base
    attr_accessor :id, :name, :url, :avatar_url, :location, :twitter_screen_name, :drafted_by_player_id, :website_url,
        :shots_count, :draftees_count, :followers_count, :following_count,
        :comments_count, :comments_received_count, :likes_count, :likes_received_count, :rebounds_count, :rebounds_received_count

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

    def draftees(options={})
      Player.paginated_list(self.class.get("/players/#{@id}/draftees", :query => options), 'players')
    end

    def followers(options={})
      Player.paginated_list(self.class.get("/players/#{@id}/followers", :query => options), 'players')
    end

    def following(options={})
      Player.paginated_list(self.class.get("/players/#{@id}/following", :query => options), 'players')
    end
  end
end
