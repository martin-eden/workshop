return
  function(self, str)
    -- print(('match [%d, "%s"]'):format(self:get_position(), str))
    local segment = self:block_read(#str)
    return (segment == str)
  end
