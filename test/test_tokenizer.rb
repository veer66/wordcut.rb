# coding: utf-8
require "test/unit"
require_relative "../wordcut/tokenizer.rb"
require_relative "../wordcut/dict.rb"

class TestTokenizer < Test::Unit::TestCase
  def setup
    @dict = BasicDict.new ["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)}
    @tokenizer = BasicTokenizer.new(@dict)
  end
  
  def test_basic

    tokens = @tokenizer.tokenize("ขามกา")
    assert_equal(["ขาม", "กา"], tokens)
  end

  def test_unk
    tokens = @tokenizer.tokenize("กาซามกา")
    assert_equal(["กา", "ซาม", "กา"], tokens)
  end
end
