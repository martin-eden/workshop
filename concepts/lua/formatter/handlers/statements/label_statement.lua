-- Serialize "label" statement

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node)
    local printer = me[2]

    printer:add_to_curline('::')
    if not me:process_node(node[1]) then
      return
    end
    printer:add_to_curline('::')

    return true
  end

--[[
  2016
  2017
  2018
]]
