-- Return line's contents by index

-- Last mod.: 2024-10-31

--[[
  Same note as for [GetNumLines]. We're using trivial wrappers for
  freedom for changes.
]]

-- Exports:
return
  function(self, Index)
    self:AssertValidIndex(Index)

    return self.Lines[Index]
  end

--[[
  2024-10-31
]]
