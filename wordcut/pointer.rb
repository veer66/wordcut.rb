class Pointer
  attr_reader :s, :l, :r, :offset, :dict, :final
  def initialize(s, l, r, offset, dict, final=false)
    @s = s
    @l = l
    @r = r
    @offset = offset
    @dict = dict
    @final = final
  end

  def update(ch)
    l = @dict.seek(ch, @l, @r, @offset, :LEFT)
    return nil unless l
    r = @dict.seek(ch, l, @r, @offset, :RIGHT)
    final = (@dict[l].headword.length == @offset + 1)
    self.class.new(@s, l, r, @offset + 1, @dict, final)
  end
end

module PointersManipulator
  def new_pointer(i, dict)
    Pointer.new(i-1, dict.l, dict.r, 0, dict)
  end
  
  def transit(pointers, ch)
    pointers.map{|p| p.update(ch)}.reject(&:nil?)
  end
end
