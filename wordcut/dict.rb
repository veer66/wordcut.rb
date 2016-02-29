require_relative "dict_seek"

class WordItem
  attr_reader :headword
  def initialize(headword)
    @headword = headword
  end
end

module DictInfo
  def l
    0
  end

  def r
    return nil if self.empty?
    self.length - 1
  end
end

class BasicDict < Array
  include DictInfo
  include DictSeeker
end
