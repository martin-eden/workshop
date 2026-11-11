-- Attribute (like "<const>") serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

return
  function(me, node)
    me[2]:add_to_curline('<')
    me:process_node(node[1])
    me[2]:add_to_curline('>')
    return true
  end

--[[
  2026-10-28
]]
