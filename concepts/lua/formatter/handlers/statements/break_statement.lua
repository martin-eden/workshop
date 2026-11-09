-- Serialize "break" statement

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me)
    me[2]:add_to_curline('break')
    return true
  end

--[[
  2016 #
  2017 #
]]
