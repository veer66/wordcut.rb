# coding: utf-8
require "test/unit"
require_relative "../wordcut/space_slicer.rb"

include Wordcut

class TestSpaceSlicer < Test::Unit::TestCase
  def setup

  end

  def test_basic    
    slicer = SpaceSlicer.new(100)
    slicer.transit(" ", "A")
    assert_equal(true, slicer.final)
    assert_equal(100, slicer.s)
    assert_equal(1, slicer.offset)
  end

  def test_non_space_basic
    slicer = SpaceSlicer.new(100)
    slicer.transit("A", " ")
    assert_equal(false, slicer.final)
  end

  def test_A_space
    slicer = SpaceSlicer.new(100)
    slicer.transit("A", " ")
    slicer.transit(" ", nil)
    assert_equal(true, slicer.final)
    assert_equal(101, slicer.s)
    assert_equal(1, slicer.offset)
  end

  def test_spaces
    slicer = SpaceSlicer.new(100)
    slicer.transit(" ", " ")
    slicer.transit(" ", "K")
    assert_equal(true, slicer.final)
    assert_equal(100, slicer.s)
    assert_equal(2, slicer.offset)
  end

end
