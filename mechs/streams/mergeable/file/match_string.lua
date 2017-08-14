return
  function(self, str)
    local segment = self:block_read(#str)
    -- print(('match [%d, "%s"]'):format(self:get_position(), str), segment == str)
    return (segment == str)
  end
