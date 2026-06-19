-- Save table to string with Lua code that recreates that table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- Imports:
local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local graph_to_str = request('!.concepts.codec_lua_graph.compile')

local table_to_str =
  function(Graph, Options)
    local StringStream = new(StringOutputStream)

    graph_to_str(Graph, StringStream, Options)

    return StringStream:GetString()
  end

-- Export:
return table_to_str

--[[
  2026 #
  2026-06-17
  2026-06-20
]]
