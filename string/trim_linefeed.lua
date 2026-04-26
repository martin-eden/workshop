-- Trim possible tail newlines from string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

local newline_chars_map =
  {
    ['\x0d'] = true,
    ['\x0a'] = true,
  }

local trim_tail_nls =
  function(str)
    assert_string(str)

    local finish_pos = #str
    while newline_chars_map[string.sub(str, finish_pos, finish_pos)] do
      finish_pos = finish_pos - 1
    end

    return string.sub(str, 1, finish_pos)
  end

-- Export:
return trim_tail_nls

--[[
  2016-09
  2026-04-26
]]
