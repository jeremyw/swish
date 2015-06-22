require 'helper'

class PaginatedListTest < Test::Unit::TestCase
  def setup
    @shots_results = { 
      "total"=>750,
      "shots"=>[{}, {}],
      "page"=>1, 
      "pages"=>375,
      "per_page"=>2
    }
  end

  def test_initialize_gathers_pagination_data
    list = Dribbble::PaginatedList.new(@shots_results)

    assert_equal 375, list.pages
    assert_equal 750, list.total
    assert_equal 1, list.page
    assert_equal 2, list.per_page
  end

  def test_list_behaves_as_array
    list = Dribbble::PaginatedList.new(@shots_results)
    assert list.is_a? Array
    assert list.respond_to?(:each)
    assert list.respond_to?(:first)
  end

  def test_initialize_collects_shots_by_default
    list = Dribbble::PaginatedList.new(@shots_results)
    assert_equal 2, list.size
    list.each { |shot| assert shot.is_a?(Dribbble::Shot), "#{shot.inspect} is not a Dribbble::Shot." }
  end

  def test_initialize_collecting_players
    player_followers_results = {
      "players"=> [{}, {}], 
      "total"=>201,
      "page"=>1,
      "pages"=>101,
      "per_page"=>2
    } 

    list = Dribbble::PaginatedList.new(player_followers_results)
    assert_equal 2, list.size
    list.each { |p| assert p.is_a?(Dribbble::Player), "#{p.inspect} is not a Dribbble::Player" }
  end

  def test_initialize_collecting_comments
    comments_results = {
      "comments"=> [{}, {}], 
      "total"=>201,
      "page"=>1,
      "pages"=>101,
      "per_page"=>2
    } 

    list = Dribbble::PaginatedList.new(comments_results)
    assert_equal 2, list.size
    list.each { |p| assert p.is_a?(Dribbble::Comment), "#{p.inspect} is not a Dribbble::Comment" }
  end

  def test_real_life
    per_page = 30
    page_count = Dribbble::Base.paginated_list(Dribbble::Base.get("/players/icco/shots/likes", :query => {:per_page => per_page})).pages
    (1..page_count).each do |page|
      list = Dribbble::Base.paginated_list(Dribbble::Base.get("/players/icco/shots/likes", :query => {:page => page, :per_page => per_page}))
      assert_equal per_page, list.size if page < page_count
      list.each { |p| assert p.is_a?(Dribbble::Shot), "#{p.inspect} is not a Dribbble::Shot" }
    end
  end
end
