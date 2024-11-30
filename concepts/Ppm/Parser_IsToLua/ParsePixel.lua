-- Parse raw pixel data

-- Last mod.: 2024-11-25

-- Imports:
local BaseColor = request('!.concepts.Image.Color.Interface')
local NormalizeColor = request('!.concepts.Image.Color.Normalize')

--[=[
  Parses raw pixel data to annotated list

  { '0', '128', '255' } -> { 0, 128, 255 --[[ aka .Red, .Green, .Blue ]] }

  In case of problems returns nil.
]=]
local ParsePixel =
  function(self, PixelIs)
    local Red = self:ParseColorComponent(PixelIs[1])
    local Green = self:ParseColorComponent(PixelIs[2])
    local Blue = self:ParseColorComponent(PixelIs[3])

    if not (Red and Green and Blue) then
      return
    end

    local Color = new(BaseColor, { Red, Green, Blue })

    NormalizeColor(Color)

    return Color
  end

-- Exports:
return ParsePixel

--[[
  2024-11-03
  2024-11-25
]]
