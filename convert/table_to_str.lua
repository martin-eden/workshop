-- Save table to string with Lua code that recreates that table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local compile_graph = request('!.concepts.codec_lua_graph.compile_graph')

local table_to_str =
  function(Graph, Options)
    local StringStream = new(StringOutputStream)

    compile_graph(Graph, StringStream, Options)

    return StringStream:GetString()
  end

-- Export:
return table_to_str

--[[
  2026 #
  2026-06-17
  2026-06-20
]]
