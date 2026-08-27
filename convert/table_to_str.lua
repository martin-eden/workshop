-- Save table to string with Lua code that recreates that table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local compile_graph = request('!.concepts.codec_lua_graph.compile_graph')

-- Export:
return
  function(Graph, Options)
    local StringStream = new(StringOutputStream)
    compile_graph(Graph, StringStream, Options)
    return StringStream:GetString()
  end

--[[
  2026 # # #
]]
