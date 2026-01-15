-- Generate .SetPixel() replacement

-- Last mod.: 2025-05-06

local Generate_SetPixel =
  function(Ours, Theirs)
    Ours.NativeSetPixel = Theirs.SetPixel

    return
      function(...)
        Ours:SetPixel(...)
      end
  end

-- Exports:
return Generate_SetPixel

--[[
  2025-04 # #
  2025-05-06
]]
