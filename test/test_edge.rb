# coding: utf-8
require "test/unit"
require_relative "../wordcut/edge.rb"

include Wordcut

class TestEdge < Test::Unit::TestCase
  def test_better
    e0 = Edge.new(:unk =>10, :chunk => 10)
    e1 = Edge.new(:unk => 5, :chunk => 20)
    assert_equal(-1 ,e1 <=> e0)
  end
end

class TestEdgeWithPayload < Test::Unit::TestCase
  def test_prefer_not_nil
    e0 = Edge.new(:unk => 10, :chunk => 10, :payload => "A")
    e1 = Edge.new(:unk => 10, :chunk => 10)
    assert_equal(-1, e0 <=> e1)
    assert_equal(1, e1 <=> e0)
  end
end
