-- Write string to <self.Output>. Update empty line state

return
  function(self, s)
    self.Output:Write(s)
    self.IsOnEmptyLine = false
  end

--[[
  2024-10-21
]]
