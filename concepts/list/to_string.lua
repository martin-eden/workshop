-- Concatenate list of string values to string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

local to_string =
  function(List, separator_str)
    assert_table(List)

    separator_str = separator_str or ''
    assert_string(separator_str)

    -- Meh, in Lua it's simple
    return table.concat(List, separator_str)
  end

-- Export:
return to_string

--[[
  2024 # #
  2026-05-29
]]
