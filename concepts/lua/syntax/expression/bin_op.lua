-- Binary operator grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-10-22
]]

--[[
  <bin_op>

    ─┬─ // ────────┬─
     ├─ == ────────┤
     ├─ ~= ────────┤
     ├─ << ────────┤
     ├─ <= ────────┤
     ├─ >> ────────┤
     ├─ >= ────────┤
     ├─ .. ────────┤
     ├─ + ─────────┤
     ├─ - ─────────┤
     ├─ * ─────────┤
     ├─ / ─────────┤
     ├─ ^ ─────────┤
     ├─ % ─────────┤
     ├─ & ─────────┤
     ├─ ~ ─────────┤
     ├─ | ─────────┤
     ├─ < ─────────┤
     ├─ > ─────────┤
     ├─ word(and) ─┤
     └─ word(or) ──┘

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

local opt_spc = request('^.words.opt_spc')
local match_regexp = request('!.mechs.parser.handy').match_regexp
local word = request('^.words.word')
local cho = handy.cho

return
  {
    opt_spc,
    {
      name = 'bin_op',
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
  }

--[[
  2018 #
  2026-10-22
]]
