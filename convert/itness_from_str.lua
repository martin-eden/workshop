-- Parse string as Itness tree

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local StringInputStream = request('!.concepts.StreamIo.Input.String')
local itness_parse = request('!.concepts.codec_itness.parse')

return
  function(str)
    local StringInputStream = new(StringInputStream)
    StringInputStream:Init(str)

    return itness_parse(StringInputStream)
  end

--[[
  2026-04-27
]]
