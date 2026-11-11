-- Serialize parenthesized expression

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local oneliner =
  function(me, node)
    me[2]:add_to_curline('(')
    if not me:process_node(node[1]) then
      return
    end
    me[2]:add_to_curline(')')
    return true
  end

local multiliner =
  function(me, node)
    local printer = me[2]

    printer:add_to_curline('(')

    printer:request_clean_line()
    if not me:process_block(node[1]) then
      return
    end

    printer:request_clean_line()
    printer:add_to_curline(')')

    return true
  end

return
  function(me, node)
    return me:variate(node, oneliner, multiliner)
  end

--[[
  2016 #
  2017 # # #
]]
