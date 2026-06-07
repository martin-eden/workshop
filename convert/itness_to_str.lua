-- Compile Itness tree to string

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Imports:
local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local itness_compile = request('!.concepts.codec_itness.compile')

local itness_to_string =
  function(ItnessTree)
    local StringOutputStream = new(StringOutputStream)

    itness_compile(ItnessTree, StringOutputStream)

    return StringOutputStream:GetString()
  end

-- Export:
return itness_to_string

--[[
  2026-04 #
  2026-05 #
]]
