-- Add string to end of list

-- Last mod.: 2024-10-31

-- Exports:
return
  function(self, String)
    self:InsertLineAfter(String, self:GetNumLines())
  end

--[[
  2024-10-31
]]
