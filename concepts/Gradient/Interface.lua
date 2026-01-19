-- Image filling interface

--[[
  Author: Martin Eden
  Last mod.: 2026-01-19
]]

--[[
  Fill image
]]
local Run_Dummy =
  function(self)
    --[[
      Code for this depends of space-filling strategy

      Generally you have to set some "parent" pixels in image and
      then calculate all other pixels somehow based on parent pixels.

      You have CreatePixel() function which calculates and sets
      pixel given list of parents.
    ]]
  end

return
  {
    -- [Config]
    Image = request('!.concepts.Image.Interface'),
    CreatePixel = request('CreatePixel'),
    -- [Run]
    Run = Run_Dummy,
  }

--[[
  2026-01-14
  2026-01-19
]]
