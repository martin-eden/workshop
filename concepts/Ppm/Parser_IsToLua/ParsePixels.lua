-- Parse raw pixels data

-- Last mod.: 2024-11-25

-- Imports:
local BaseMatrix = request('!.concepts.Image.Matrix.Interface')
local BaseImageLine = request('!.concepts.Image.Line.Interface')

--[[
  Parse raw pixels data.

  { { { '0', '128', '255' } } } ->

  -- aka .Lines
  {
    -- aka .Colors
    {
      -- aka .Red, .Green, .Blue
      { 0, 128, 255 }
    }
  }
]]
local ParsePixels =
  function(self, DataIs, Header)
    local Result = new(BaseMatrix)

    for Row = 1, Header.Height do
      local PixelsRow = new(BaseImageLine)

      for Column = 1, Header.Width do
        local PixelIs = DataIs[Row][Column]
        local Pixel = self:ParsePixel(PixelIs)

        if not Pixel then
          return
        end

        PixelsRow.Colors[Column] = Pixel
      end

      PixelsRow.Length = Header.Width

      Result.Lines[Row] = PixelsRow
    end

    Result.NumLines = #Result.Lines

    return Result
  end

-- Exports:
return ParsePixels

--[[
  2024-11-03
  2024-11-25
]]
