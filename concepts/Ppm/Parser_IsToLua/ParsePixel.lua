-- Parse raw pixel data

-- Last mod.: 2024-11-25

-- Imports:
local CreateColor = request('!.concepts.Image.Color.Spawner.Create')

--[[
  Parses raw pixel data to custom Lua table.

  { '0', '128', '255' } -> { Red = 0, Green = 128, Blue = 255 }

  In case of problems returns nil.
]]
local ParsePixel =
  function(self, PixelIs)
    local Red = self:ParseColorComponent(PixelIs[1])
    local Green = self:ParseColorComponent(PixelIs[2])
    local Blue = self:ParseColorComponent(PixelIs[3])

    if not (Red and Green and Blue) then
      return
    end

    return CreateColor({ Red, Green, Blue })
  end

-- Exports:
return ParsePixel

--[[
  2024-11-03
  2024-11-25
]]
