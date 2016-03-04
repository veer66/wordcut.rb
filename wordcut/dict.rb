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

module PathResolver
  def resolve_path(lang, name)
    File.expand_path(File.join(__FILE__, '..', '..', 'data', lang, name, ))
  end
end

module BasicDictLoader
  include PathResolver
  def load_bundle(lang, name)
    load(resolve_path(lang, name))
  end

  def load(path)
    self.concat(open(path).each_line
                 .map(&:strip)
                 .reject(&:empty?)
                 .map{|w| WordItem.new w})
  end
end

class BasicDict < Array
  include DictInfo
  include DictSeeker
  include BasicDictLoader

  def self.from_bundle(lang, name)
    dict = self.new
    dict.load_bundle(lang, name)
    return dict
  end
end
