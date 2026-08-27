-- Characters and their ASCII codes used in Lua quoting

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local AsciiCodes = request('!.concepts.Ascii.Codes')
local AsciiChars = request('!.concepts.Ascii.Chars')

-- Export:
return
  {
    single_quote_code = AsciiCodes.single_quote,
    single_quote = AsciiChars.single_quote,

    double_quote_code = AsciiCodes.double_quote,
    double_quote = AsciiChars.double_quote,

    backslash_code = AsciiCodes.backslash,
    backslash = AsciiChars.backslash,
  }

--[[
  2026-07-12
]]
