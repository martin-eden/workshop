-- Character is line comment end?

-- Last mod.: 2025-03-28

return
  function(self, Char)
    return self.LineCommentEndMap[Char]
  end

--[[
  2025-03-28
]]
