require 'httparty'
require 'dribbble/paginated_list'
require 'dribbble/base'
require 'dribbble/comment'
require 'dribbble/shot'
require 'dribbble/player'

module Dribbble
  class PlayerNotFound < Exception; end
end
