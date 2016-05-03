module Wordcut

  class Edge
    attr_reader :unk, :chunk, :s, :payload, :etype
    
    CMP_FUNCS = [lambda {|e| e.unk}, lambda {|e| e.chunk}]
    
    def initialize(args = {})
      @unk = args[:unk] || 0
      @chunk = args[:chunk] || 0
      @s = args[:s] || 0
      @payload = args[:payload]
      @etype = args[:etype]
    end

    def <=>(o)
      for fn in CMP_FUNCS
        cmp = fn.call(self) <=> fn.call(o)
        return cmp if cmp != 0
      end
      return 0
    end
  end

end
