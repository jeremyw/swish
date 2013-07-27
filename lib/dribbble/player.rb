module Dribbble
  class Player < Base
    def self.fetch(url, options = {})
      user = get(url, options)

      if user.response.is_a?(Net::HTTPOK)
        user
      else
        raise PlayerNotFound
      end
    end

    def self.find(id)
      new(fetch("/players/#{id}"))
    end

    # Fetches this player's shots.
    # Options: :page, :per_page
    def shots(options={})
      paginated_list(self.class.fetch("/players/#{@id}/shots", :query => options))
    end

    # Fetches shots by players that this player follows.
    def shots_following(options={})
      paginated_list(self.class.fetch("/players/#{@id}/shots/following", :query => options))
    end

    def draftees(options={})
      paginated_list(self.class.fetch("/players/#{@id}/draftees", :query => options))
    end

    def followers(options={})
      paginated_list(self.class.fetch("/players/#{@id}/followers", :query => options))
    end

    def following(options={})
      paginated_list(self.class.fetch("/players/#{@id}/following", :query => options))
    end
  end
end
