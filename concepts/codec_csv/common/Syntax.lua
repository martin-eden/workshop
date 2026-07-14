-- CSV syntax characters

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

local newline_char = '\010'
local comma_char = ','
local quote_char = '"'

local Syntax =
  {
    records_separator = newline_char,
    fields_separator = comma_char,
    quote_char = quote_char,
  }

-- Export:
return Syntax

--[[
  2026-07-14
]]
