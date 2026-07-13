-- Parse data in TSV format (tab-separated values)

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

--[[
  Output data format

  List of lists of strings:

    { { 'a', 'b' }, { }, { 'c' } }

    is fine and is parsed from

      a \t b \n \n c \n
]]

--[[
  I suppose in "standard" last record may not have tail \n

  However this decoder will drop such last record:
  ( a \n b ) will be decoded to ( ( a ) ).

  Reason is that I see no practical need to support this tweak.

  If you have such weird data -- add tail newline if it's missing
  before calling this decoder.
]]

-- Imports:
local Syntax = request('common.Syntax')

local fields_separator = Syntax.fields_separator
local records_separator = Syntax.records_separator

local add_to_list = request('!.concepts.list.add_item')

local parse =
  function(InputStream)
    local Data = { }

    local Row = { }
    local field_str = ''

    local add_field = false
    local add_row = false

    while true do
      local char = InputStream:Read(1)

      if (char == '') then break end

      if (char == fields_separator) then
        add_field = true
      elseif (char == records_separator) then
        add_field = true
        add_row = true
      else
        field_str = field_str .. char
      end

      if add_field then
        add_to_list(Row, field_str)
        field_str = ''

        add_field = false
      end

      if add_row then
        add_to_list(Data, Row)
        Row = { }

        add_row = false
      end
    end

    return Data
  end

-- Export:
return parse

--[[
  2026-07-13
]]
