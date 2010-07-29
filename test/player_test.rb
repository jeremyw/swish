require 'helper'

class PlayerTest < Test::Unit::TestCase
  def test_find
    player = Dribbble::Player.find(1)
    assert_equal 1, player.id
    assert_equal 'Dan Cederholm', player.name
    assert_equal 'http://dribbble.com/players/simplebits', player.url
    assert_equal 'Salem, MA', player.location
  end

  def test_shots
    player = Dribbble::Player.find(1)
    shots = player.shots
    assert_equal 15, shots.size, "default page size"
    shots.each do |shot|
      assert_kind_of Dribbble::Shot, shot
      assert_kind_of Dribbble::Player, shot.player
      assert_equal player, shot.player
    end

    shots = player.shots(:per_page => 2)
    assert_equal 2, shots.size
    shots.each do |shot|
      assert_equal player, shot.player
    end
  end

  def test_shots_following
    player = Dribbble::Player.find(1)
    shots = player.shots_following
    assert_equal 15, shots.size, "default page size"
    shots.each do |shot|
      assert_kind_of Dribbble::Shot, shot
      assert_kind_of Dribbble::Player, shot.player
      assert_not_equal player, shot.player
    end

    shots = player.shots_following(:per_page => 2)
    assert_equal 2, shots.size
    shots.each do |shot|
      assert_not_equal player, shot.player
    end
  end
end