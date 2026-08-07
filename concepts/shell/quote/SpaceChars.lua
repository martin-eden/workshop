-- Whitespace characters in shell

--[[
  Author: Martin Eden
  Last mod.: 2026-08-07
]]

--[[
  Whitespaces are context-free special characters

  Also they are used to apply special meaning to
  context-dependent "#" comment character:

    If the first non-space character in string is "#" then
    next characters till newline is comment.

    So " # c <nl>b" is comment " c " and token "b".
]]

--[[
  Because whitespaces serve several roles they live in separate
  module.
]]

-- Imports:
local AsciiChars = request('!.concepts.Ascii.Chars')

local SpaceChars =
  {
    AsciiChars.tab,
    AsciiChars.newline,
    AsciiChars.space,
  }

-- Export:
return SpaceChars

--[[
  2026-06-09
]]
