-- Write string as line to output

--[[
  Author: Martin Eden
  Last mod.: 2026-01-26
]]

-- Exports:
return
  function(self, Data, Comment)
    if Data then
      self.Output:Write(Data)
    end

    if Comment then
      if Data then
        self.Output:Write('  ')
      end

      self.Output:Write(self.Settings.LineCommentChar)
      self.Output:Write(' ')
      self.Output:Write(Comment)
    end

    if Data or Comment then
      self.Output:Write('\n')
    end
  end

--[[
  2024-11-02
  2025-04-09
]]
