-- Generate .SetPixel() replacement

-- Last mod.: 2025-04-26

local Generate_SetPixel =
  function(Ours, Theirs)
    local NativeSetPixel = Theirs.SetPixel

    return
      function(self, Point, Color)
        Ours:GranulateColor(Color)
        NativeSetPixel(self, Point, Color)
      end
  end

-- Exports:
return Generate_SetPixel

--[[
  2025-04-26
]]
