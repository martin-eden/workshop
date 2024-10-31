-- Return string from last line

-- Last mod.: 2024-10-31

-- Exports:
return
  function(self)
    return self:GetLineAt(self:GetNumLines())
  end

--[[
  2024-10-31
]]
