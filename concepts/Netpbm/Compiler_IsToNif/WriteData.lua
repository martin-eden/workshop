-- Write pixels to output

-- Last mod.: 2025-04-09

-- Imports:
local ListToString = request('!.concepts.List.ToString')

-- Exports:
return
  function(self, DataIs)
    local Settings = self.Settings

    assert(Settings.DataEncoding == 'Text')

    local ColorFormat = Settings.ColorFormat

    local NumColorsPerDataLine

    if (ColorFormat == 'Rgb') then
      NumColorsPerDataLine = 4
    elseif (ColorFormat == 'Gs') then
      NumColorsPerDataLine = 12
    end

    local Height = #DataIs
    local Width = #DataIs[1]

    local ColumnsDelim = '  '

    self:WriteLine(LinesDelim)

    for Row = 1, Height do
      local Chunk = {}

      self:WriteLine('')
      self:WriteLine(nil, ('Line %d'):format(Row))

      for Column = 1, Width do
        local ColorIs = DataIs[Row][Column]
        local ColorStr = self:CompileColor(ColorIs)

        table.insert(Chunk, ColorStr)

        if (Column % NumColorsPerDataLine == 0) then
          local ChunksStr = ListToString(Chunk, ColumnsDelim)
          Chunk = {}

          self:WriteLine(ChunksStr)
        end
      end

      -- Write remained chunk
      if (Width % NumColorsPerDataLine ~= 0) then
        local ChunksStr = ListToString(Chunk, ColumnsDelim)
        self:WriteLine(ChunksStr)
      end
    end
  end

--[[
  2024-11 # #
  2025-04-09
]]
