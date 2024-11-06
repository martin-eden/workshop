-- Parse raw pixel data

-- Last mod.: 2024-11-03

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

    return
      {
        Red = Red,
        Green = Green,
        Blue = Blue,
      }
  end

-- Exports:
return ParsePixel

--[[
  2024-11-03
]]
