-- Generate .SetPixel() replacement

--[[
  Author: Martin Eden
  Last mod.: 2026-01-19
]]

local Generate_SetPixel =
  function(Ours, Theirs)
    Ours.NativeSetPixel = Theirs.SetPixel

    return
      function(...)
        Ours.Image:SetPixel(...)
      end
  end

-- Exports:
return Generate_SetPixel

--[[
  2025-04 # #
  2025-05-06
]]
