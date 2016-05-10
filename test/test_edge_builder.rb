# coding: utf-8
require "test/unit"
require_relative "../wordcut/edge_builder.rb"
require_relative "../wordcut/edge.rb"
require_relative "../wordcut/pointer.rb"
require_relative "../wordcut/dict.rb"

include Wordcut

class TestDag < Array
  include EdgeBuilder
end

class TestDict
  def initialize(content)
    @content = content
  end

  def [](i)
    @content[i]
  end
end

class TestEdgeBuilder < Test::Unit::TestCase
  def test_build
    @dict = TestDict.new(["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)})
    dag = TestDag.new
    dag << Edge.new(:s => 0, :unk => 0, :chunk => 0, :etype => :INIT)
    final_pointers = [Pointer.new(0, 1, 2, 1, @dict)]
    edges = dag.build_edges(final_pointers)
    assert_equal(1, edges.length)
    assert_equal(1, edges[0].chunk)
    assert_equal(:DICT, edges[0].etype)
    assert_equal(0, edges[0].s)
  end

  def test_build_with_payload
    @dict = TestDict.new([["กา", "A"], ["ขา", "B"],
                          ["ขาม", "C"], ["มา", "C"]]
                          .map{|headword, payload|
                           WordItemWithPayload.new(headword, payload)})
    dag = TestDag.new
    dag << Edge.new(:s => 0, :unk => 0, :chunk => 0, :etype => :INIT)
    final_pointers = [Pointer.new(0, 1, 2, 1, @dict)]
    edges = dag.build_edges(final_pointers)
    assert_equal(1, edges.length)
    assert_equal(1, edges[0].chunk)
    assert_equal("B", edges[0].payload)
    assert_equal(:DICT, edges[0].etype)
    assert_equal(0, edges[0].s)
  end

end
