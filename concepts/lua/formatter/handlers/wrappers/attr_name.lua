-- Attributed name serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    local printer = me[2]
    me:process_node(node[1])
    if node[2] then
      printer:add_to_curline(' ')
      me:process_node(node[2])
    end
    return true
  end

--[[
  2026-10-28
]]
