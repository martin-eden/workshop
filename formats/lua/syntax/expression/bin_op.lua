--[[
  Binary operator grammar.

  <bin_op>:

  -+- <opt_spc> -+- "//" --------+-
                 +- "==" --------+
                 +- "~=" --------+
                 +- "<<" --------+
                 +- "<=" --------+
                 +- ">>" --------+
                 +- ">=" --------+
                 +- ".." --------+
                 +- "+" ---------+
                 +- "-" ---------+
                 +- "*" ---------+
                 +- "/" ---------+
                 +- "^" ---------+
                 +- "%" ---------+
                 +- "&" ---------+
                 +- "~" ---------+
                 +- "|" ---------+
                 +- "<" ---------+
                 +- ">" ---------+
                 +- word("and") -+
                 +- word("or") --+

  Order

    <x> must be before <y> because <y> is a prefix of <x>:

    <x> <y>

    //   /
    ~=   ~
    <<   <
    <=   <
    >>   >
    >=   >
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local match_regexp = request('!.mechs.parser.handy').match_regexp

local opt_spc = request('^.words.opt_spc')
local word = request('^.words.word')

return
  {
    name = 'bin_op',
    opt_spc,
    cho(
      '//',
      '==',
      '~=',
      '<<',
      '<=',
      '>>',
      '>=',
      '..',
      match_regexp('[%+%-%*%/%^%%%&%~%|%<%>]'),
      word('and'),
      word('or')
    ),
  }
