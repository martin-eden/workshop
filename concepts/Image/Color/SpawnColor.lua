-- Create color record, depending of color format

--[[
  Author: Martin Eden
  Last mod.: 2026-01-15
]]

-- Imports:
local RgbColor = request('Rgb')
local GsColor = request('Grayscale')
local BwColor = request('BlackWhite')

--[[
  Create color instance depending of string with color format.

  In case of fail explodes.
]]
local SpawnColor =
  function(ColorType)
    if (ColorType == 'rgb') then
      return new(RgbColor)
    elseif (ColorType == 'gs') then
      return new(GsColor)
    elseif (ColorType == 'bw') then
      return new(BwColor)
    else
      error(('Unknown color format %q.'):format(ColorType))
    end
  end

-- Exports:
return SpawnColor

--[[
  2025 # # #
  2026-01-15
]]
