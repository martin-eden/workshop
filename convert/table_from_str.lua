-- Return Lua table from string with Lua code

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local tree_from_str = request('!.concepts.lua_table.parse')
local graph_from_str = request('!.concepts.lua_table_code.parse')

local table_from_str =
  function(str)
    local Graph

    Graph = tree_from_str(str)
    if Graph then return Graph end

    Graph = graph_from_str(str)
    if Graph then return Graph end
  end

-- Export:
return table_from_str

--[[
  2026-05-05
]]
