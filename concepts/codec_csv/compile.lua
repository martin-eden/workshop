-- Serialize data to CSV (comma-separated values) output stream

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local check_data = request('compile.check_data')
local Syntax = request('common.Syntax')
local quote_field = request('common.quote_field')

local records_separator = Syntax.records_separator
local fields_separator = Syntax.fields_separator

local compile =
  function(Data, OutputStream)
    if not check_data(Data) then
      error('Bad data.')
    end

    for row_index, Row in ipairs(Data) do
      for field_index, field_str in ipairs(Row) do
        local is_first_field = (field_index == 1)
        if not is_first_field then
          OutputStream:Write(fields_separator)
        end
        OutputStream:Write(quote_field(field_str))
      end
      OutputStream:Write(records_separator)
    end
  end

-- Export:
return compile

--[[
  2026-07-14
]]
