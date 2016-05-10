# coding: utf-8
require "test/unit"
require_relative "../wordcut/dict_seek.rb"
require_relative "../wordcut/dict.rb"

include Wordcut

class TestDict < Array
  include DictSeeker
end

class TestDictSeeker < Test::Unit::TestCase
  def setup
    @dict = TestDict.new ["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)}
  end
  
  def test_simple   
    assert_equal(1,  @dict.seek('ข', 0, @dict.length - 1, 0, :LEFT))
  end
  
  def test_right
    assert_equal(2,  @dict.seek('ข', 0, @dict.length - 1, 0, :RIGHT))
  end

end
