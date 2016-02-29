require_relative "dag.rb"

module Tokenizer
  def tokenize(txt)
    @dag_class.build(@dict, txt).tokens(txt)
  end
end

class BasicTokenizer
  include Tokenizer
  def initialize(dict)
    @dict = dict
    @dag_class = BasicDag
  end
end

