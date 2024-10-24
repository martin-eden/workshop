-- Assure that next string will be written on new line

return
  function(self)
    if self.IsOnEmptyLine then
      return
    end
    self:Emit(self.Syntax.Delimiters.Newline)
    self.IsOnEmptyLine = true
  end

--[[
  2024-10-21
]]
