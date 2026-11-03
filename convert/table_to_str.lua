-- Save table to string with Lua code that recreates that table

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local compile_graph = request('!.concepts.codec_lua_graph.compile_graph')

return
  function(Graph, Options)
    local ResultString = StringOutputStream.create()
    compile_graph(Graph, ResultString, Options)
    return ResultString:GetString()
  end

--[[
  2026 # # #
]]
