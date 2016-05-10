# coding: utf-8
require "test/unit"
require_relative "../wordcut/tokenizer.rb"
require_relative "../wordcut/dict.rb"

include Wordcut

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

  def test_completely_unk
    tokens = @tokenizer.tokenize("ซาม")
    assert_equal(["ซาม"], tokens)
  end

  def test_latin
    tokens = @tokenizer.tokenize("que sera sera")
    assert_equal(["que", " ", "sera", " ", "sera"], tokens)
  end

end
