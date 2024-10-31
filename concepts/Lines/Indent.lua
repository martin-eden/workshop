-- Indent lines

-- Last mod.: 2024-10-31

--[[
  In our class we're not separating indentation from lines text.
  So we'll modify lines text.
]]

-- Exports:
return
  function(self)
    local IndentChunk = self.IndentChunk

    for Index, Line in ipairs(self.Lines) do
      self.Lines[Index] = IndentChunk .. Line
    end
  end

--[[
  2024-10-31
]]
