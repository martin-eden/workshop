return
  function(self, num_positions)
    local cur_pos = self.position
    local new_pos = cur_pos + num_positions
    local result = self.s:sub(cur_pos, new_pos - 1)
    self:set_position(new_pos)
    -- print(('read [%d, %d, "%s"]'):format(cur_pos, num_positions, result))
    return result
  end
