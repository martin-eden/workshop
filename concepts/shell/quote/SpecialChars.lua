-- Context-free non-ordinary characters in shell

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local SpaceChars = request('SpaceChars')
local add_list = request('!.concepts.list.add_list')

local SpecialChars =
  {
    -- '!',
    '"',
    -- '#',
    '$',
    -- '%',
    '&',
    "'",
    '(',
    ')',
    '*',
    -- '+',
    -- ',',
    -- '-',
    -- '.',
    -- '/',
    -- ':',
    ';',
    '<',
    -- '=',
    '>',
    -- '?',
    -- '@',
    '[',
    [[\]],
    ']',
    '^',
    -- '_',
    '`',
    '{',
    '|',
    '}',
    -- '~',
  }

add_list(SpecialChars, SpaceChars)

-- Export:
return SpecialChars

--[[
  2026-06-09
  2026-06-12
]]
