# coding: utf-8
require "test/unit"
require_relative "../wordcut/tokenizer.rb"
require_relative "../wordcut/dict.rb"

class TestTokenizer < Test::Unit::TestCase
  def setup
    @dict = BasicDict.new ["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)}
  end
  
  def test_basic
    tokenizer = BasicTokenizer.new(@dict)
    tokens = tokenizer.tokenize("ขามกา")
    assert_equal(["ขาม", "กา"], tokens)
  end
end
