-- Parse data

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

return
  function(self)
    local result = {}
    while true do
      local rec = self:get_next_rec()
      if not rec then break end
      result[#result + 1] = rec
    end
    return result
  end

--[[
  2017
]]
