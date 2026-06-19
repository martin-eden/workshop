-- Save table to string with Lua code for table definition

--[[
  Author: Martin Eden
  Last mod.: 2026-06-19
]]

-- Imports:
local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local graph_is_tree = request('!.table.is_tree')
local tree_to_str = request('!.concepts.lua_table.compile')
local graph_to_str = request('!.concepts.lua_table_code.compile')

local table_to_str =
  function(Graph, Options)
    local StringStream = new(StringOutputStream)

    if graph_is_tree(Graph) then
      tree_to_str(Graph, StringStream, Options)
    else
      graph_to_str(Graph, StringStream, Options)
    end

    return StringStream:GetString()
  end

-- Export:
return table_to_str

--[[
  2026-05-05
  2026-06-17
]]
