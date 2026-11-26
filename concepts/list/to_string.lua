-- Concatenate list of string values to string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-26
]]

local tbl_concat = table.concat

return
  function(list, separator_str)
    assert_table(list)
    separator_str = separator_str or ''
    assert_string(separator_str)
    return tbl_concat(list, separator_str)
  end

--[[
  2024 # #
  2026 #
]]
