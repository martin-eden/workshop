--[[
  Implementation detail:

    Explicit check for <num_positions> == 0 is needed for case
    when we read zero bytes at end of file. In this case io.read()
    will return nil instead of empty string.
]]

return
  function(self, num_positions)
    -- print(('raw_read [%d, %d]'):format(self:get_position(), num_positions))

    if (num_positions == 0) then
      return '', 0
    end

    local s = self.f:read(num_positions)
    if s then
      return s, #s
    end
  end
