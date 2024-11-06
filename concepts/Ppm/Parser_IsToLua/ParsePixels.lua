-- Parse raw pixels data

-- Last mod.: 2024-11-03

--[[
  Parse raw pixels data.

  { [1] = { { '0', '128', '255' } } }
    ->
  { [1] = { { Red = 0, Green = 128, Blue = 255 } } }
]]
local ParsePixels =
  function(self, DataIs, Header)
    local Result = {}

    for Row = 1, Header.Height do
      local PixelsRow = {}

      for Column = 1, Header.Width do
        local PixelIs = DataIs[Row][Column]
        local Pixel = self:ParsePixel(PixelIs)

        if not Pixel then
          return
        end

        table.insert(PixelsRow, Pixel)
      end

      table.insert(Result, PixelsRow)
    end

    return Result
  end

-- Exports:
return ParsePixels

--[[
  2024-11-03
]]
