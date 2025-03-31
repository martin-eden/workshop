-- Character is "normal delimiter" or comment start?

-- Last mod.: 2025-03-28

return
  function(self, Char)
    return
      self:IsSpace(Char) or
      self:IsLineCommentStart(Char)
  end

--[[
  2025-03-28
]]
