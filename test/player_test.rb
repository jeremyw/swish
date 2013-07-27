require 'helper'

class PlayerTest < Test::Unit::TestCase
  def test_find
    player = Dribbble::Player.find(1)
    assert_equal 1, player.id
    assert_equal 'Dan Cederholm', player.name
    assert_equal 'http://dribbble.com/simplebits', player.url
    assert_equal 'http://simplebits.com', player.website_url
    assert_equal 'Salem, MA', player.location
    assert_not_nil player.created_at
    assert_equal 'simplebits', player.twitter_screen_name
    assert_nil player.drafted_by_player_id # no one drafted Dan

    numerics = [
        :shots_count, :draftees_count, :followers_count, :following_count,
        :comments_count, :comments_received_count, :likes_count,
        :likes_received_count, :rebounds_count, :rebounds_received_count
    ]

    numerics.each do |field|
      assert_kind_of Numeric, player.send(field), "Expected #{field} to be Numeric but it was #{field.class}"
    end
  end

  def test_finding_invalid_user
    assert_raises(Dribbble::PlayerNotFound) do
      Dribbble::Player.find(999999)
    end
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
    end

    shots = player.shots_following(:per_page => 2)
    assert_equal 2, shots.size
    shots.each do |shot|
      assert_kind_of Dribbble::Shot, shot
      assert_kind_of Dribbble::Player, shot.player
    end
  end

  def test_draftees
    player = Dribbble::Player.find(1)
    draftees = player.draftees
    assert_equal 15, draftees.size, "default page size"
    draftees.each do |draftee|
      assert_kind_of Dribbble::Player, draftee
    end

    draftees = player.draftees(:per_page => 2)
    assert_equal 2, draftees.size
  end

  def test_followers
    player = Dribbble::Player.find(1)
    followers = player.followers
    assert_equal 15, followers.size, "default page size"
    followers.each do |follower|
      assert_kind_of Dribbble::Player, follower
    end

    followers = player.followers(:per_page => 2)
    assert_equal 2, followers.size
  end

  def test_following
    player = Dribbble::Player.find(1)
    following = player.following
    assert_equal 15, following.size, "default page size"
    following.each do |following_player|
      assert_kind_of Dribbble::Player, following_player
    end

    following = player.following(:per_page => 2)
    assert_equal 2, following.size
  end
end
