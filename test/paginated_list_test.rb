require 'helper'

class PaginatedListTest < Test::Unit::TestCase
  def setup
    @api_response = 
      { "total"=>750,
        "shots"=>[
          { "created_at"=>"2010/09/25 12:51:30 -0400",
            "short_url"=>"http://drbl.in/58261",
            "player"=>{
              "name"=>"Parthiban Mohanraj",
              "likes_received_count"=>835,
              "avatar_url"=>"http://dribbble.com/system/users/2706/avatars/thumb/Avatar.png?1275677669",
              "twitter_screen_name"=>"ParthibanM",
              "shots_count"=>25,
              "location"=>"Toronto, Canada",
              "created_at"=>"2010/06/04 14:04:13 -0400",
              "likes_count"=>7,
              "following_count"=>10,
              "draftees_count"=>0,
              "rebounds_count"=>2,
              "url"=>"http://dribbble.com/players/parthiban",
              "username"=>"parthiban",
              "website_url"=>"http://kamikaze00x.deviantart.com/",
              "id"=>2706,
              "followers_count"=>197,
              "drafted_by_player_id"=>917,
              "comments_count"=>39,
              "comments_received_count"=>223,
              "rebounds_received_count"=>2
            },
            "title"=>"Icon",
            "image_url"=>"http://dribbble.com/system/users/2706/screenshots/58261/shot_1285433490.png",
            "likes_count"=>85,
            "rebounds_count"=>0,
            "url"=>"http://dribbble.com/shots/58261-Icon",
            "id"=>58261,
            "image_teaser_url"=>"http://dribbble.com/system/users/2706/screenshots/58261/shot_1285433490_teaser.png",
            "height"=>300,
            "comments_count"=>15,
            "views_count"=>1419,
            "width"=>400
          },
          { "created_at"=>"2010/09/22 19:49:00 -0400",
            "short_url"=>"http://drbl.in/57478",
            "player"=>{
              "name"=>"Michael Flarup",
              "likes_received_count"=>1439,
              "avatar_url"=>"http://dribbble.com/system/users/784/avatars/thumb/flarup-flarup.jpg?1264596401",
              "twitter_screen_name"=>"flarup",
              "shots_count"=>54,
              "location"=>"Copenhagen",
              "created_at"=>"2010/01/24 20:28:44 -0500",
              "likes_count"=>17,
              "following_count"=>35,
              "draftees_count"=>6,
              "rebounds_count"=>9,
              "url"=>"http://dribbble.com/players/flarup",
              "username"=>"flarup",
              "website_url"=>"http://pixelresort.com",
              "id"=>784,
              "followers_count"=>360,
              "drafted_by_player_id"=>212,
              "comments_count"=>97,
              "comments_received_count"=>419,
              "rebounds_received_count"=>25
            }, 
            "title"=>"Old Safari",
            "image_url"=>"http://dribbble.com/system/users/784/screenshots/57478/shot_1285199340.png",
            "likes_count"=>130,
            "rebounds_count"=>2,
            "url"=>"http://dribbble.com/shots/57478-Old-Safari",
            "id"=>57478,
            "image_teaser_url"=>"http://dribbble.com/system/users/784/screenshots/57478/shot_1285199340_teaser.png",
            "height"=>300,
            "comments_count"=>23,
            "views_count"=>2954,
            "width"=>400
          }],
        "page"=>1, 
        "pages"=>375,
        "per_page"=>2
      }
  end

  def test_initialize_gathers_pagination_data
    @list = Dribbble::PaginatedList.new(@api_response)

    assert_equal 375, @list.pages
    assert_equal 750, @list.total
    assert_equal 1, @list.page
    assert_equal 2, @list.per_page
  end

  def test_list_behaves_as_array
    @list = Dribbble::PaginatedList.new(@api_response)
    assert @list.is_a? Array
    assert @list.respond_to?(:each)
    assert @list.respond_to?(:first)
  end

  def test_initialize_collects_shots_by_default
    @list = Dribbble::PaginatedList.new(@api_response)
    assert_equal 2, @list.size
    @list.each do |shot|
      assert shot.instance_of?(Dribbble::Shot), "#{shot.inspect} is not an instance of Dribbble::Shot."
    end
  end
end
