-- Write pixels to output. We're doing some formatting

-- Last mod.: 2024-11-06

-- Imports:
local ListToString = request('!.concepts.List.ToString')

-- Exports:
return
  function(self, DataIs, Header)
    local ChunkSize = self.NumColumns
    local ColumnsDelim = self.ColumnsDelimiter
    local LinesDelim = self.LinesDelimiter

    self:WriteLine(LinesDelim)

    for Row = 1, Header.Height do
      local Chunks = {}

      for Column = 1, Header.Width do
        local PixelIs = DataIs[Row][Column]
        local PixelStr = self:CompilePixel(PixelIs)

        table.insert(Chunks, PixelStr)

        if (Column % ChunkSize == 0) then
          local ChunksStr = ListToString(Chunks, ColumnsDelim)
          Chunks = {}

          self:WriteLine(ChunksStr)
        end
      end

      -- Write remained chunk
      if (Header.Width % ChunkSize ~= 0) then
        local ChunksStr = ListToString(Chunks, ColumnsDelim)
        self:WriteLine(ChunksStr)
      end

      self:WriteLine(LinesDelim)
    end
  end

--[[
  2024-11-02
  2024-11-03
]]
