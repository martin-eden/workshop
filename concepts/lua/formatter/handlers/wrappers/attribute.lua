-- Attribute (like "<const>") serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    local printer = me[2]
    printer:add_to_curline('<')
    me:process_node(node[1])
    printer:add_to_curline('>')
    return true
  end

--[[
  2026-10-28
]]
