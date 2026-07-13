-- Check that provided data is in format suitable for our serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local Syntax = request('^.common.Syntax')

local fields_separator = Syntax.fields_separator
local records_separator = Syntax.records_separator

local str_find = string.find

local check_data =
  function(Data)
    if not is_table(Data) then return false end

    for row_index, Row in ipairs(Data) do

      if not is_table(Row) then return false end

      for field_index, field in ipairs(Row) do
        if not is_string(field) then return false end

        if str_find(field, fields_separator) then return false end
        if str_find(field, records_separator) then return false end
      end
    end

    return true
  end

-- Export:
return check_data

--[[
  2026-07-13
]]
