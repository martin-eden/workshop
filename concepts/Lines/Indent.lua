-- Indent lines

--[[
  Author: Martin Eden
  Last mod.: 2026-04-24
]]

--[[
  In our class we're not separating indentation from lines text.
  So we'll modify lines text.
]]

-- Exports:
return
  function(self)
    local IndentChunk = self.IndentChunk

    for Index, Line in ipairs(self.Lines) do
      if (Line ~= '') then
        self.Lines[Index] = IndentChunk .. Line
      end
    end
  end

--[[
  2024-10-31
  2026-04-24
]]
