-- Parse raw pixel data

-- Last mod.: 2025-03-31

-- Imports:
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local NormalizeColor = request('!.concepts.Image.Color.Normalize')

--[=[
  Parses raw pixel data to color record:

    { '0', '128', '255' } -> { 0.0, 0.5, 1.0 }

  Note that number of color components is not fixed to three.
  We should work fine with one-component (grayscale) colors.

  In case of problems returns nil.
]=]
local ParsePixel =
  function(self, PixelIs)
    local Color = SpawnColor(self.Settings.ColorFormat)

    for Index, ValueIs in ipairs(PixelIs) do
      local ComponentValue = self:ParseColorComponent(ValueIs)

      if not ComponentValue then
        return
      end

      Color[Index] = ComponentValue
    end

    NormalizeColor(Color)

    return Color
  end

-- Exports:
return ParsePixel

--[[
  2024-11-03
  2024-11-25
  2025-03-28
]]
