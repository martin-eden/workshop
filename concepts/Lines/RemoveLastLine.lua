-- Remove last line from the list

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

return
  function(self)
    self:RemoveLineAt(self:GetNumLines())
  end

--[[
  2026-04-17
]]
