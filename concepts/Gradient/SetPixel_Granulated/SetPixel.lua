-- SetPixel() wrapping with color quantization

-- Last mod.: 2025-05-06

local SetPixel =
  function(Ours, Theirs, Point, Color)
    if Color then
      Ours:GranulateColor(Color)
    end

    Ours.NativeSetPixel(Theirs, Point, Color)
  end

-- Exports:
return SetPixel

--[[
  2025-05-06
]]
