--[[
  Unary operator grammar.

  <un_op>:

    -+- <opt_spc> -+- "-" ---+---+-
     |             +- "#" ---+   |
     |             +- "~" ---+   |
     +- word("not") -------------+
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local match_regexp = request('!.mechs.parser.handy').match_regexp

local opt_spc = request('^.words.opt_spc')
local word = request('^.words.word')

return
  {
    name = 'un_op',
    cho(
      {opt_spc, match_regexp('[%-%#%~]')},
      word('not')
    ),
  }
