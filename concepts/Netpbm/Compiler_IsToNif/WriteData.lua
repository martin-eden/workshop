-- Write pixels to output

--[[
  Author: Martin Eden
  Last mod.: 2026-01-25
]]

-- Imports:
local ListToString = request('!.concepts.List.ToString')

-- Exports:
return
  function(self, DataIs)
    local Settings = self.Settings

    assert(Settings.DataEncoding == 'text')

    local ColorFormat = Settings.ColorFormat

    local NumColorsPerDataLine

    if (ColorFormat == 'rgb') then
      NumColorsPerDataLine = 4
    elseif (ColorFormat == 'gs') then
      NumColorsPerDataLine = 12
    elseif (ColorFormat == 'bw') then
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
  2024 # #
  2025 #
  2026-01-13
]]
