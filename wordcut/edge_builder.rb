require_relative "edge.rb"

module Wordcut
  module EdgeBuilder
    def init_edge
      Edge.new
    end
    
    def build_edges(pointers)
      pointers.map do |pointer|
        src = self[pointer.s]
        Edge.new(:s => pointer.s,
                 :unk => src.unk,
                 :chunk => src.chunk + 1,
                 :etype => :DICT,
                 :payload => nil)
      end                    
    end
  end
end
