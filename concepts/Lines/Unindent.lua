-- Unindent lines

-- Last mod.: 2024-10-31

--[[
  Just removes indentation chunk from every line. If it can.
]]

-- Exports:
return
  function(self)
    local IndentChunk = self.IndentChunk
    local IndentChunkLen = string.len(IndentChunk)

    for Index, Line in ipairs(self.Lines) do
      local LinePrefix = string.sub(Line, 1, IndentChunkLen)
      if (LinePrefix == IndentChunk) then
        local LinePostfix = string.sub(Line, IndentChunkLen + 1)
        self.Lines[Index] = LinePostfix
      end
    end
  end

--[[
  2024-10-31
]]
