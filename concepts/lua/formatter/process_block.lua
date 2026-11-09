-- Serialize node as block (in indent)

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

return
  function(me, node, handler)
    local printer = me[2]
    local result
    printer:inc_indent()
    if handler then
      result = handler(me, node)
    else
      result = me:process_node(node)
    end
    printer:dec_indent()
    return result
  end

--[[
  2017 #
]]
