-- Remove spaces at start of string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

local trim_head =
  function(str)
    assert_string(str)

    local read_pos = 1

    while (string.sub(str, read_pos, read_pos) == ' ') do
      read_pos = read_pos + 1
    end

    return string.sub(str, read_pos, string.len(str))
  end

-- Export:
return trim_head

--[[
  2017-01-17
]]
