# coding: utf-8
require "test/unit"
require_relative "../wordcut/tokenizer.rb"
require_relative "../wordcut/dict.rb"

include Wordcut

class TestTokenizer < Test::Unit::TestCase
  def setup
    @dict = BasicDict.from_bundle("tha", "tdict-std.txt")
    @tokenizer = BasicTokenizer.new(@dict)
  end

  def test_seek_bug
    s = "ค้นหาสิ่งต่าง ๆ ได้เร็วขึ้นด้วยทางลัดคำแนะนำการค้นหาที่เป็นประโยชน์"
    #s = "ค้นหา"
    tokens = @tokenizer.tokenize(s)
    assert_equal(["ค้น","หา"], tokens[0..1])
  end

end
