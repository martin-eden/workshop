-- Check that integer is ASCII control code

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

-- Export:
return
  function(code)
    return (code <= 31) or (code == 127)
  end

--[[
  2026-08-01
  2026-08-07
  2026-08-27
]]
