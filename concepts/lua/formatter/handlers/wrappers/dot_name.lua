-- Serialize dotted name

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    me[2]:add_to_curline('.')
    return me:process_node(node[1])
  end

--[[
  2016 #
  2017 #
  2018 #
]]
