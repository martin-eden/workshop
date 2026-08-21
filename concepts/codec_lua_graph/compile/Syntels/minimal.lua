-- Minimal syntax elements

--[[
  Author: Martin Eden
  Last mod.: 2026-08-22
]]

local space
local newline
do
  local AsciiChars = request('!.concepts.Ascii.Chars')
  space = AsciiChars.space
  newline = AsciiChars.newline
end

-- Export:
return
  {
    start_table = '{',
    end_table = '}',
    empty_table = '{}',
    start_index = '[',
    end_index = ']',
    assign = '=',
    item_separator = ',',

    kw_local = 'local' .. space,
    name_separator = '.',
    statement_separator = newline,
    kw_return = 'return' .. space,
  }

--[[
  2026-08-15
  2026-08-22
]]
