-- Parse string as Itness tree

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local string_input_stream = request('!.concepts.streams.input.string')
local itness_parse = request('!.concepts.codec_itness.parse')

return
  function(str)
    local string_input_stream = string_input_stream.create(str)

    return itness_parse(string_input_stream)
  end

--[[
  2026-04-27
]]
