require_relative "edge_builder"
require_relative "pointer"
require_relative "space_slicer"

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

module SpaceDagUpdater
  def update_by_space(i, slicer)
    s = slicer.s
    src = self[s]      
    edge = Edge.new(:s => s,
                    :unk => src.unk,
                    :chunk => src.chunk + 1,
                    :etype => :SPACE,
                    :payload => nil)
    self[i] = edge
    return i
  end
end

module BasicDagUpdater
  include DictDagUpdater
  include UnkDagUpdater
  include SpaceDagUpdater
  include PointersManipulator
  
  def update(i, left, pointers, space_slicer)
    if not pointers&.empty?
      update_by_dict(i, pointers)
    elsif space_slicer&.final
      update_by_space(i, space_slicer)
    else
      update_by_unk(i, left)
    end
  end
end

module DagBuilder
  def build(dict, txt)
    self[0] = init_edge
    pointers = []
    left = 0
    space_slicer = SpaceSlicer.new(0)
    for i in 1..txt.length
      ch = txt[i - 1]
      next_ch = i < txt.length ? txt[i] : nil
      space_slicer.transit(ch, next_ch)
      pointers << new_pointer(i, dict)
      pointers = transit(pointers, ch)
      left = update(i, left, pointers.select(&:final), space_slicer)
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
