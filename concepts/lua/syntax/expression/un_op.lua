-- Unary operator grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-10-23
]]

--[[
  <un_op>

    ─┬─ - ─────────┬─
     ├─ # ─────────┤
     ├─ ~ ─────────┤
     └─ word(not) ─┘
]]

local match_regexp = request('!.mechs.parser.handy').match_regexp
local word = request('^.words.word')
local cho = request('!.mechs.processor.handy').cho

return
  {
    name = 'un_op',
    cho(
      match_regexp('[%-%#%~]'),
      word('not')
    ),
  }

--[[
  2018 #
  2026-10-23
]]
