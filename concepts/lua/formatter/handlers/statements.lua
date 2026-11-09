-- Serialize sequence of statements

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Each statement starts with new line, except <empty_statement> ";".
]]

local multiliner =
  function(me, node)
    local printer = me[2]

    for _, Subnode in ipairs(node) do
      if (Subnode.type ~= 'empty_statement') then
        printer:request_clean_line()
      end
      if not me:process_node(Subnode) then
        return
      end
    end

    return true
  end

return
  function(me, node)
    return me:variate(node, nil, multiliner)
  end

--[[
  2016 #
  2017 # # # #
]]
