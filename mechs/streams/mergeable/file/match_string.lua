return
  function(self, str)
    local orig_pos = self:get_position()
    local segment = self:read(#str)
    -- print(('match [%d, "%s"]'):format(self:get_position(), str), segment == str)
    if (segment ~= str) then
      self:set_position(orig_pos)
      return false
    else
      return true
    end
  end
