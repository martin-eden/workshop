-- Characters and their ASCII codes used in Lua quoting

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local ascii_codes = request('!.concepts.ascii.codes')
local ascii_chars = request('!.concepts.ascii.chars')

return
  {
    single_quote_code = ascii_codes.single_quote,
    single_quote = ascii_chars.single_quote,

    double_quote_code = ascii_codes.double_quote,
    double_quote = ascii_chars.double_quote,

    backslash_code = ascii_codes.backslash,
    backslash = ascii_chars.backslash,
  }

--[[
  2026-07-12
]]
