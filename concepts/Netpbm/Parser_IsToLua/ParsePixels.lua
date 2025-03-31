-- Parse raw pixels data

-- Last mod.: 2024-11-25

--[=[
  Parse raw pixels data.

  { { { '0', '128', '255' } } } ->

  { { { 0, 128, 255 --[[ aka .Red, .Green, .Blue ]] } } }
]=]
local ParsePixels =
  function(self, DataIs)
    local Matrix = {}

    for RowIndex, Row in ipairs(DataIs) do
      Matrix[RowIndex] = {}

      for ColumnIndex, PixelIs in ipairs(Row) do
        local Pixel = self:ParsePixel(PixelIs)

        if not Pixel then
          return
        end

        Matrix[RowIndex][ColumnIndex] = Pixel
      end
    end

    return Matrix
  end

-- Exports:
return ParsePixels

--[[
  2024-11-03
  2024-11-25
]]
