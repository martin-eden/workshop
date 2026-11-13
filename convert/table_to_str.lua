-- Save table to string with Lua code that recreates that table

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local string_output_stream = request('!.concepts.streams.output.string')
local compile_graph = request('!.concepts.codec_lua_graph.compile_graph')

return
  function(graph, options)
    local output = string_output_stream.create()
    compile_graph(graph, output, options)
    return output:get_string()
  end

--[[
  2026 # # #
]]
