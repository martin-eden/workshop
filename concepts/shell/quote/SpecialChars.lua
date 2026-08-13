-- Context-free non-ordinary characters in shell

--[[
  Author: Martin Eden
  Last mod.: 2026-08-13
]]

local SpecialChars
do
  local SpaceChars = request('SpaceChars')
  local add_list = request('!.concepts.list.add_list')

  SpecialChars =
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
end

return SpecialChars

--[[
  2026-06-09
  2026-06-12
]]
