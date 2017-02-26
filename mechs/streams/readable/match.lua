return
  function(self, str)
    local seg_len = #str
    local segment = self:block_read(seg_len)
    return segment and (segment == str)
  end
