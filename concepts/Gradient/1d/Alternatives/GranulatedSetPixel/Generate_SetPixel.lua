-- Generate .SetPixel() replacement

-- Last mod.: 2025-04-28

local Generate_SetPixel =
  function(Ours, Theirs)
    local NativeSetPixel = Theirs.SetPixel

    return
      function(self, Point, Color)
        if Color then
          Ours:GranulateColor(Color)
        end

        NativeSetPixel(self, Point, Color)
      end
  end

-- Exports:
return Generate_SetPixel

--[[
  2025-04-26
  2025-04-28
]]
