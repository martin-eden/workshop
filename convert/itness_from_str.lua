-- Parse string as Itness table

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

-- Imports:
local StringInputStreamClass = request('!.concepts.StreamIo.Input.String')
local ItnessParser = request('!.concepts.Itness.Interface')

-- Itness from string
local itness_from_string =
  function(str)
    local StringInputStream = new(StringInputStreamClass)
    StringInputStream.String = str

    return ItnessParser:Parse(StringInputStream)
  end

-- Export:
return itness_from_string

--[[
  2026-04-27
]]
