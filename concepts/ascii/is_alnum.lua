-- Check that integer is ASCII letter or digit

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

-- Export:
return
  function(code)
    return
      ((code >= 65) and (code <= 90)) or
      ((code >= 97) and (code <= 122)) or
      ((code >= 48) and (code <= 57))
  end

--[[
  2026-08-27
]]
