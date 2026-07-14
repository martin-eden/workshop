-- Verify data for CSV eligibleness

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local str_find = string.find

local check_data =
  function(Data)
    if not is_table(Data) then return false end

    for row_index, Row in ipairs(Data) do
      if not is_table(Row) then return false end

      for field_index, field_str in ipairs(Row) do
        if not is_string(field_str) then return false end
      end
    end

    return true
  end

-- Export:
return check_data

--[[
  2026-07-14
]]
