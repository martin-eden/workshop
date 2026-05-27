-- Parse string as Itness tree

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

-- Imports:
local StringInputStreamClass = request('!.concepts.StreamIo.Input.String')
local ItnessCodec = request('!.concepts.Codec_Itness.Interface')

local itness_from_string =
  function(str)
    local StringInputStream = new(StringInputStreamClass)
    StringInputStream:Init(str)

    return ItnessCodec:Parse(StringInputStream)
  end

-- Export:
return itness_from_string

--[[
  2026-04-27
]]
