-- Parse raw pixels data

--[[
  Author: Martin Eden
  Last mod.: 2026-01-15
]]

-- Imports:
local ImageBase = request('!.concepts.Image.Interface')

--[=[
  Parse raw pixels data.

  { { { '0', '128', '255' } } } ->

  { { { 0, 128, 255 --[[ aka .Red, .Green, .Blue ]] } } }
]=]
local ParsePixels =
  function(self, DataIs)
    local Image = new(ImageBase)

    for Y = 1, #DataIs do
      local Row = DataIs[Y]
      for X = 1, #Row do
        local Pixel = self:ParsePixel(Row[X])

        if not Pixel then
          return
        end

        Image:SetPixel({Y, X}, Pixel)
      end
    end

    return Image
  end

-- Exports:
return ParsePixels

--[[
  2024-11-03
  2024-11-25
  2026-01-15
]]
