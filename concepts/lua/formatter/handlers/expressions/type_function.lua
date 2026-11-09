-- Serialize function

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local multiliner =
  function(me, node)
    local printer = me[2]

    printer:request_clean_line()
    printer:add_to_curline('function')
    if not me:process_node(node.params) then
      return
    end

    printer:request_clean_line()
    return me:process_block_multiline(nil, node.body, 'end')
  end

return
  function(me, node)
    return me:variate(node, nil, multiliner)
  end

--[[
  2016 #
  2017 # # #
]]
