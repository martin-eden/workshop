-- Parse string with qualified name to custom structure

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

--[[
  Result structure

    Ancestors [t] -- list of part names
    Name [s] -- leaf node name
]]

--[[
  Example:

    "Whole" "." ->
      Ancestors = ( )
      Name = "Whole"

    "Whole.Part" "." ->
      Ancestors = ( "Whole" )
      Name = "Part"
]]

-- Imports:
local split_string = request('!.string.split')
local select_range = request('!.concepts.list.select_range')

local parse_name =
  function(name, names_delimiter)
    local Result = { }

    local Parts = split_string(name, names_delimiter)

    Result.Name = Parts[#Parts]

    if (#Parts == 1) then
      Result.Ancestors = { }
    else
      Result.Ancestors = select_range(Parts, 1, #Parts - 1)
    end

    return Result
  end

-- Export:
return parse_name

--[[
  2026-05-02
]]
