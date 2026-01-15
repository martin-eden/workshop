-- Create function to substitute [Gradient.1d.CreatePixel]

-- Last mod.: 2025-04-26

local Generate_CreatePixel =
  function(Ours)
    return
      function(...)
        Ours:CreatePixel(...)
      end
  end

-- Exports:
return Generate_CreatePixel

--[[
  2025-04-23
  2025-04-26
]]
