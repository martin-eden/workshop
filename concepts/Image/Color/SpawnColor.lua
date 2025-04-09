-- Create color record, depending of color format

-- Last mod.: 2025-04-09

-- Imports:
local RgbColor = request('Rgb')
local GsColor = request('Grayscale')

--[[
  Create color instance depending of string with color format.

  In case of fail explodes.
]]
local SpawnColor =
  function(ColorType)
    if (ColorType == 'Rgb') then
      return new(RgbColor)
    elseif (ColorType == 'Gs') then
      return new(GsColor)
    else
      error(('Unknown color format %q.'):format(ColorType))
    end
  end

-- Exports:
return SpawnColor

--[[
  2025-03 # #
  2025-04-09
]]
