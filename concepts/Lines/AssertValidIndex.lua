-- Assert that value is valid index

-- Last mod.: 2024-11-01

-- Exports:
return
  function(self, Index)
    assert_integer(Index)

    local NumLines = self:GetNumLines()
    local IsEmpty = (NumLines == 0)

    if IsEmpty then
      assert((Index == 0) or (Index == 1))
    else
      assert(Index >= 1)
      assert(Index <= NumLines)
    end
  end

--[[
  2024-10-31
  2024-11-01
]]
