-- Set line's contents

-- Last mod.: 2024-10-31

-- Exports:
return
  function(self, String, Index)
    self:AssertValidValue(String)
    self:AssertValidIndex(Index)

    self.Lines[Index] = String
  end

--[[
  2024-10-31
]]
