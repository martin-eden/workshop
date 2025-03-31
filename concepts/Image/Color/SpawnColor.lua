-- Create color record, depending of color format

-- Last mod.: 2025-03-31

-- Imports:
local RgbColor = request('Rgb')
local GsColor = request('Grayscale')

-- Exports:
return
  function(ColorType)
    if (ColorType == 'Rgb') then
      return new(RgbColor)
    elseif (ColorType == 'Grayscale') then
      return new(GsColor)
    end
  end

--[[
  2025-03-29
  2025-03-31
]]
