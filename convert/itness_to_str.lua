-- Compile Itness table to string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

-- Imports:
local StringOutputStreamClass = request('!.concepts.StreamIo.Output.String')
local ItnessCompiler = request('!.concepts.Itness.Serializer.Interface')

-- Itness to string
local itness_to_string =
  function(Is)
    local StringOutputStream = new(StringOutputStreamClass)

    ItnessCompiler.Output = StringOutputStream
    ItnessCompiler:Run(Is)

    return StringOutputStream:GetString()
  end

-- Export:
return itness_to_string

--[[
  2026-04-27
]]
