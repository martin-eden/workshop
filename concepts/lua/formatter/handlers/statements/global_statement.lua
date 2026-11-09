-- Serialize "global" statement

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    local printer = me[2]
    printer:add_to_curline('global ')
    if not me:process_block(node[1]) then return end
    if node[2] then
      printer:add_to_curline(' = ')
      if not me:process_block(node[2]) then return end
    end
    return true
  end

--[[
  2026-10-28
]]
