-- Character is line comment start?

-- Last mod.: 2025-03-28

return
  function(self, Char)
    return self.LineCommentStartMap[Char]
  end

--[[
  2025-03-28
]]
