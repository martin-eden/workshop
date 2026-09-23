-- Compile Itness tree to string

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local itness_compile = request('!.concepts.codec_itness.compile')

return
  function(ItnessNode)
    local StringOutputStream = new(StringOutputStream)

    itness_compile(ItnessNode, StringOutputStream)

    return StringOutputStream:GetString()
  end

--[[
  2026-04 #
  2026-05 #
]]
