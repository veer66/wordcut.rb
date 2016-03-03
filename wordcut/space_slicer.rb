class SpaceSlicer
  attr_reader :s, :offset, :final
  
  def initialize(s)
    @s = s
    @offset = 0
    @final = false
  end
      
  def transit(ch, next_ch)
    current_is_space = (ch =~ /\s/)
    next_is_space = (not nil? and next_ch =~ /\s/)
    
    if current_is_space and next_is_space
      @offset += 1
    elsif current_is_space and not next_is_space
      @offset += 1
      @final = true
    elsif not current_is_space 
      @final = false
      @s += @offset
      @s += 1
      @offset = 0
    end
  end
end
