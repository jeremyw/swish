module Dribbble
  class Comment < Base
    attr_reader :player
    def initialize(attributes={})
      @player = Dribbble::Player.new(attributes.delete('player')) if attributes['player']
      super
    end
  end
end
