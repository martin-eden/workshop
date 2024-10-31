-- Assert that value is valid index

-- Last mod.: 2024-10-31

-- Exports:
return
  function(self, Index)
    assert_integer(Index)
    assert(Index >= 0)
    assert(Index <= self:GetNumLines())
  end

--[[
  2024-10-31
]]
