module DictSeeker
  def seek(ch, l, r, offset, policy)
    idx = nil
    while l <= r
      m = (l + r) / 2
      w = self[m].headword
      wlen = w.length

      if wlen <= offset
        l = m + 1
      else
        ch_w = w[offset]
        if ch_w < ch
          l = m + 1
        elsif ch_w > ch
          r = m - 1
        elsif policy == :LEFT
          idx = m
          r = m - 1
        elsif policy == :RIGHT
          idx = m
          l = m + 1
        end        
      end
    end
    return idx
  end
end
