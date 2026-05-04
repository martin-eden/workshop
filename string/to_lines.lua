-- Convert string to list of lines

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local lines_iterator = request('!.string.lines')

--[[
  Explode string to list of lines.

  For empty string '', we're returning empty table { }.
  Not table with empty string { '' }.
]]
local string_to_lines =
  function(str)
    assert_string(str)

    -- Special case: return "{ }" for empty string
    if (str == '') then
      return { }
    end

    local Result = { }

    for idx, line in lines_iterator(str) do
      table.insert(Result, line)
    end

    return Result
  end

-- Exports:
return string_to_lines

--[[
  2024 # # #
  2026-05-04
]]
