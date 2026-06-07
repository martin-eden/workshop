-- Parse string as Itness tree

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Imports:
local StringInputStream = request('!.concepts.StreamIo.Input.String')
local itness_parse = request('!.concepts.codec_itness.parse')

local itness_from_string =
  function(str)
    local StringInputStream = new(StringInputStream)
    StringInputStream:Init(str)

    return itness_parse(StringInputStream)
  end

-- Export:
return itness_from_string

--[[
  2026-04-27
]]
