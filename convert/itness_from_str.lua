-- Parse string as Itness table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

-- Imports:
local StringInputStreamClass = request('!.concepts.StreamIo.Input.String')
local ItnessParser = request('!.concepts.Itness.Parser.Interface')

-- Itness from string
local itness_from_string =
  function(str)
    local StringInputStream = new(StringInputStreamClass)
    StringInputStream.String = str

    ItnessParser.Input = StringInputStream

    return ItnessParser:Run()
  end

-- Export:
return itness_from_string

--[[
  2026-04-27
]]
