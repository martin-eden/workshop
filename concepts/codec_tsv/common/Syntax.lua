-- TSV syntax characters

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

local tab_char = '\009'
local newline_char = '\010'

local Syntax =
  {
    fields_separator = tab_char,
    records_separator = newline_char,
  }

-- Export:
return Syntax

--[[
  2026-07-13
]]
