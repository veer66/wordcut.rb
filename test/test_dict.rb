# coding: utf-8
require "test/unit"
require_relative "../wordcut/dict.rb"

include Wordcut

class TestBasicDictLoader < Test::Unit::TestCase
  def test_basic
    loader = Object.extend(BasicDictLoader)
    loader.extend(Test::Unit::Assertions)
    loader.extend(Module.new do
                    def concat(wordlist)
                      assert_equal 15374, wordlist.length
                    end
                  end)
    loader.load_bundle("tha", "tdict-std.txt")
  end
end

class TestBasicDict < Test::Unit::TestCase
  def test_basic
    dict = BasicDict::from_bundle("tha", "tdict-std.txt")
    assert_equal 15374, dict.length
  end
end
