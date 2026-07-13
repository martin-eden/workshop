-- Serialize data to TSV format (tab-separated values)

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

--[[
  Input data format

  List of lists of strings:

    { { 'a', 'b' }, { }, { 'c' } }

    is fine and will be serialized to

      a \t b \n \n c \n
]]

-- Imports:
local Syntax = request('common.Syntax')
local check_data = request('compile.check_data')

local fields_separator = Syntax.fields_separator
local records_separator = Syntax.records_separator

local compile =
  function(Data, OutputStream)
    if not check_data(Data) then
      error('Bad data.')
    end

    for row_index, Row in ipairs(Data) do
      for field_index, field_str in ipairs(Row) do
        local is_first = (field_index == 1)
        if not is_first then
          OutputStream:Write(fields_separator)
        end
        OutputStream:Write(field_str)
      end
      OutputStream:Write(records_separator)
    end
  end

-- Export:
return compile

--[[
  2026-07-13
]]
