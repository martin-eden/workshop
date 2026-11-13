-- Compile Itness tree to string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local string_output_stream = request('!.concepts.streams.output.string')
local itness_compile = request('!.concepts.codec_itness.compile')

return
  function(itness_node)
    local string_output_stream = string_output_stream.create()

    itness_compile(itness_node, string_output_stream)

    return string_output_stream:get_string()
  end

--[[
  2026-04 #
  2026-05 #
]]
