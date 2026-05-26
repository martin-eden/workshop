-- Compile Itness tree to string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

-- Imports:
local StringOutputStreamClass = request('!.concepts.StreamIo.Output.String')
local ItnessCodec = request('!.concepts.Codec_Itness.Interface')

local itness_to_string =
  function(ItnessTree)
    local StringOutputStream = new(StringOutputStreamClass)

    ItnessCodec:Compile(ItnessTree, StringOutputStream)

    return StringOutputStream:GetString()
  end

-- Export:
return itness_to_string

--[[
  2026-04-27
  2026-05-26
]]
