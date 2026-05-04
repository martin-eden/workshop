-- Write pixels to output

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local AddToList = request('!.concepts.list.add_item')
local ListToString = request('!.concepts.list.to_string')

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
      local Chunks = { }

      self:WriteLine('')
      self:WriteLine(nil, ('Line %d'):format(Row))

      for Column = 1, Width do
        local ColorIs = DataIs[Row][Column]
        local ColorStr = self:CompileColor(ColorIs)

        AddToList(Chunks, ColorStr)

        if (Column % NumColorsPerDataLine == 0) then
          self:WriteLine(ListToString(Chunks, ColumnsDelim))
          Chunks = { }
        end
      end

      -- Write remained chunk
      if (Width % NumColorsPerDataLine ~= 0) then
        self:WriteLine(ListToString(Chunks, ColumnsDelim))
      end
    end
  end

--[[
  2024 # #
  2025 #
  2026-01-13
]]
