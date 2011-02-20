require 'helper'

class ShotTest < Test::Unit::TestCase
  def test_initialize
    shot = Dribbble::Shot.new(
        'id'                => 999,
        'title'             => 'Title',
        'url'               => 'http://url',
        'image_url'         => 'http://image_url',
        'image_teaser_url'  => 'http://image_teaser_url',
        'width'             => 3,
        'height'            => 2,
        'created_at'        => '2010/05/21 16:34:42 -0400')

    assert_equal 999, shot.id
    assert_equal 'Title', shot.title
    assert_equal 'http://url', shot.url
    assert_equal 'http://image_url', shot.image_url
    assert_equal 'http://image_teaser_url', shot.image_teaser_url
    assert_equal 3, shot.width
    assert_equal 2, shot.height
    assert_equal Time.parse('2010/05/21 16:34:42 -0400'), shot.created_at
  end

  def test_find
    shot = Dribbble::Shot.find(21603)
    assert_kind_of Dribbble::Shot, shot
    assert_equal 21603, shot.id
    assert_equal 'Moon', shot.title
    assert_equal 'http://dribbble.com/shots/21603-Moon', shot.url
    assert_match /http:\/\/dribbble.com\/system\/users\/1\/screenshots\/21603\/shot_1274474082.png\?\d+/, shot.image_url
    assert_match /http:\/\/dribbble.com\/system\/users\/1\/screenshots\/21603\/shot_1274474082_teaser.png\?\d+/, shot.image_teaser_url
    assert_equal 400, shot.width
    assert_equal 300, shot.height

    assert_kind_of Numeric, shot.views_count
    assert_kind_of Numeric, shot.likes_count
    assert_kind_of Numeric, shot.comments_count
    assert_kind_of Numeric, shot.rebounds_count

    assert_kind_of Dribbble::Player, shot.player
  end

  def test_comments
    shot = Dribbble::Shot.find(21603)
    comments = shot.comments
    assert comments.is_a?(Dribbble::PaginatedList), "#{comments.inspect} is not a Dribbble::PaginatedList."
    comments.each { |c| assert c.is_a?(Dribbble::Comment), "#{c.inspect} is not a Dribbble::Comment." }
  end

  def test_debuts
    shots = Dribbble::Shot.debuts
    assert_kind_of Array, shots
    assert_kind_of Dribbble::Shot, shots.first

    shots_page2 = Dribbble::Shot.debuts(:page => 2)
    assert_not_equal shots_page2[0], shots[0]

    s = Dribbble::Shot.debuts(:per_page => 3)
    assert_equal 3, s.size
  end

  def test_everyone
    shots = Dribbble::Shot.everyone(:per_page => 2)
    assert_equal 2, shots.size
    assert_kind_of Dribbble::Shot, shots.first
  end

  def test_popular
    shots = Dribbble::Shot.popular(:per_page => 2)
    assert_equal 2, shots.size
    assert_kind_of Dribbble::Shot, shots.first
  end
end
