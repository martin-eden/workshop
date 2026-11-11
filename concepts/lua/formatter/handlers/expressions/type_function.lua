-- Serialize function

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local multiliner =
  function(me, node)
    me[2]:request_clean_line()
    me[2]:add_to_curline('function')
    if not me:process_node(node.params) then
      return
    end
    me[2]:request_clean_line()
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
