-- Convert string to list of lines

-- Last mod.: 2024-11-20

-- Imports:
local LinesIterator = request('!.string.lines')

--[[
  Explode string to list of lines.

  For empty string '', we're returning empty table {}.
  Not table with empty string {''}.
]]
local StringToLines =
  function(s)
    assert_string(s)

    -- Special case: return "{}" for empty string
    if (s == '') then
      return {}
    end

    local Result = {}

    for NextReadIdx, Line in LinesIterator(s) do
      table.insert(Result, Line)
    end

    return Result
  end

-- Exports:
return StringToLines

--[[
  2024-02
  2024-03
  2024-11
]]
