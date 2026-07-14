-- Quote string to CSV if needed

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local Syntax = request('^.common.Syntax')

local quote_char = Syntax.quote_char

local str_gsub = string.gsub

local do_quote =
  function(str)
    str = str_gsub(str, quote_char, quote_char .. quote_char)

    return quote_char .. str .. quote_char
  end

local records_separator = Syntax.records_separator
local fields_separator = Syntax.fields_separator
local str_find = string.find

local quote_field =
  function(field_str)
    local needs_quoting =
      str_find(field_str, records_separator) or
      str_find(field_str, fields_separator) or
      str_find(field_str, quote_char)

    if not needs_quoting then
      return field_str
    end

    return do_quote(field_str)
  end

-- Export:
return quote_field

--[[
  2026-07-14
]]
