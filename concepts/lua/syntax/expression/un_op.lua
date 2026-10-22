-- Unary operator grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-10-22
]]

--[[
  <un_op>

    ─┬─ - ─────────┬─
     ├─ # ─────────┤
     ├─ ~ ─────────┤
     └─ word(not) ─┘
]]

local opt_spc = request('^.words.opt_spc')
local match_regexp = request('!.mechs.parser.handy').match_regexp
local word = request('^.words.word')
local cho = request('!.mechs.processor.handy').cho

return
  {
    opt_spc,
    {
      name = 'un_op',
      cho(
        match_regexp('[%-%#%~]'),
        word('not')
      ),
    },
  }

--[[
  2018 #
  2026-10-22
]]
