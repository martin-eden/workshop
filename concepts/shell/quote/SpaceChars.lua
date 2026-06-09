-- Whitespace characters in shell

--[[
  Author: Martin Eden
  Last mod.: 2026-06-09
]]

-- Imports:

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

local SpaceChars =
  {
    '\009',
    '\010',
    ' ',
  }

-- Export:
return SpaceChars

--[[
  2026-06-09
]]
