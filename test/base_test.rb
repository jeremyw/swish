require 'helper'

class BaseTest < Test::Unit::TestCase
  def test_attributes_are_methods
    base = Dribbble::Base.new('foo' => 'bar', 'baz' => 'qux')
    assert base.respond_to?(:foo)
    assert base.respond_to?(:baz)
    assert_equal 'bar', base.foo
    assert_equal 'qux', base.baz
  end
end
