# coding: utf-8
require "test/unit"
require_relative "../wordcut/edge.rb"

class TestEdge < Test::Unit::TestCase
  def test_better
    e0 = Edge.new(:unk =>10, :chunk => 10)
    e1 = Edge.new(:unk => 5, :chunk => 20)
    assert_equal(-1 ,e1 <=> e0)
  end
end
