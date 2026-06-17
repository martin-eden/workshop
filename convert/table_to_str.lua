-- Save table to string with Lua code for table definition

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local graph_is_tree = request('!.table.is_tree')
local tree_to_str = request('!.concepts.lua_table.compile')
local graph_to_str = request('!.concepts.lua_table_code.compile')

local table_to_str =
  function(Graph)
    if graph_is_tree(Graph) then
      return tree_to_str(Graph)
    end

    return graph_to_str(Graph)
  end

-- Export:
return table_to_str

--[[
  2026-05-05
  2026-06-17
]]
