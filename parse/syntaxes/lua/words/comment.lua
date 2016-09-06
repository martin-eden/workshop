local parser = request('^.^.^.parser')
local handy = parser.handy

local long_bracket = request('particles.long_bracket')

local comment =
  {
    '--',
    handy.cho1(
      long_bracket,
      handy.match_pattern('[^\n\r]*')
    )
  }

return comment
