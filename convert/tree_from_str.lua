-- Return tree table from string with Lua expression for that tree

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local parse = request('!.concepts.codec_lua_graph.parse')
local is_tree = request('!.table.is_tree')

return
  function(str)
    local tree = parse(str)

    if not is_table(tree) then
      error('Failed to parse.')
    end

    if not is_tree(tree) then
      error('Is not tree.')
    end

    return tree
  end

--[[
  2026 #
]]
