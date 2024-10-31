-- Remove line from list

-- Last mod.: 2024-10-31

-- Exports:
return
  function(self, Index)
    self:AssertValidIndex(Index)

    table.remove(self.Lines, Index)
  end

--[[
  2024-10-31
]]
