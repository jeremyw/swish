require 'helper'

class CommentTest < Test::Unit::TestCase

  def test_comment_has_a_player_object
    comment = Dribbble::Comment.new('player' => {})
    assert comment.player.is_a?(Dribbble::Player), "#{comment.player.inspect} is not a Dribbble::Player."
  end

end
