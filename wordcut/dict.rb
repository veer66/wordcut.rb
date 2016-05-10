require_relative "dict_seek"
module Wordcut
  class WordItem
    attr_reader :headword, :payload
    def initialize(headword)
      @headword = headword
      @payload = nil
    end    
  end

  class WordItemWithPayload
    attr_reader :headword, :payload
    def initialize(headword, payload)
      @headword = headword
      @payload = payload
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
                   .sort
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

    def self.load(path)
      dict = self.new
      dict.load(path)
      return dict
    end
  end

  class DictWithPayload < Array
    include DictSeeker
  end
end
