# coding: utf-8
require "test/unit"
require_relative "../wordcut/pointer.rb"
require_relative "../wordcut/dict.rb"
require_relative "../wordcut/dict_seek.rb"

class TestDict < Array
  include DictInfo
  include DictSeeker
end

class TestPointer < Test::Unit::TestCase
  def setup
    @dict = TestDict.new(["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)})
    @p0 = Pointer.new(0, @dict.l, @dict.r, 0, @dict)
  end

  def test_update
    p0_u = @p0.update("ข")
    assert_equal(1, p0_u.l)
    assert_equal(2, p0_u.r)
    assert_equal(1, p0_u.offset)
    assert_not_send([p0_u, :final])
  end
  
  def test_final
    p0_u = @p0.update("ข")&.update("า")
    assert_send([p0_u, :final])
  end

end


class TestPointersMan
  include PointersManipulator
end

class TestPointerManipulator < Test::Unit::TestCase
  def setup
    @dict = TestDict.new(["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)})
    @pointers = [Pointer.new(0, @dict.l, @dict.r, 1, @dict),
                 Pointer.new(1, @dict.l, @dict.r, 0, @dict)]
  end

  def test_transit
    pointer_man = TestPointersMan.new
    pointers = pointer_man.transit(@pointers, "า")
    assert_equal(1, pointers.length)
    assert_equal(0, pointers[0].s)
    assert_equal(true, pointers[0].final)
  end
end

