-- Itness format syntax

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local chars = request('!.concepts.ascii.chars')

return
  {
    delimiters_space_char = chars.space,
    delimiters_newline_char = chars.newline,
    quote_open_char = chars.opening_bracket,
    quote_close_char = chars.closing_bracket,
    group_open_char = chars.opening_paren,
    group_close_char = chars.closing_paren,
  }

--[[
  2024 #
  2026 #
  2026-11-13
]]
