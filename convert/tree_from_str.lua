-- Return tree table from string with Lua expression for that tree

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local parse = request('!.concepts.codec_lua_graph.parse')
local is_tree = request('!.table.is_tree')

local tree_from_str =
  function(str)
    local Tree = parse(str)

    if not is_table(Tree) then
      error('Failed to parse.')
    end

    if not is_tree(Tree) then
      error('Is not tree.')
    end

    return Tree
  end

-- Export:
return tree_from_str

--[[
  2026-08-11
]]
