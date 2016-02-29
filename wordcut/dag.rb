require_relative "edge_builder"
require_relative "pointer"

module DictDagUpdater
  def update_by_dict(i, pointers)
    edge = self.build_edges(pointers).min
    self[i] = edge
    return i
  end
end

module UnkDagUpdater
  def update_by_unk(i, left)
    src = self[left]
    edge = Edge.new(:s => left,
                    :unk => src.unk + 1,
                    :chunk => src.chunk + 1,
                    :etype => :UNK,
                    :payload => nil)
    self[i] = edge
    return left
  end
end

module BasicDagUpdater
  include DictDagUpdater
  include UnkDagUpdater
  include PointersManipulator
  
  def update(i, left, pointers)
    if pointers&.empty?
      update_by_unk(i, left)
    else
      update_by_dict(i, pointers)
    end
  end
end

module DagBuilder
  def build(dict, txt)
    self[0] = init_edge
    pointers = []
    left = 0
    for i in 1..txt.length
      ch = txt[i - 1]
      pointers << new_pointer(i, dict)
      pointers = transit(pointers, ch)
      update(i, left, pointers)
    end
  end
end

module DagToToken
  def tokens(txt)
    toks = []
    i = txt.length
    while i > 0
      s = self[i].s
      tok = txt.slice(s, i-s)
      toks << tok
      i = s
    end
    toks.reverse
  end
end

class BasicDag < Array
  include EdgeBuilder
  include BasicDagUpdater
  include DagBuilder
  include DagToToken
  
  def self.build(dict, txt)
    dag = BasicDag.new(txt.length + 1)
    dag.build(dict, txt)
    return dag
  end
end
