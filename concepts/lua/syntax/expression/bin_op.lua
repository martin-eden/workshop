-- Binary operator grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-10-23
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

local match_regexp = request('!.mechs.parser.handy').match_regexp
local word = request('^.words.word')
local cho = request('!.mechs.processor.handy').cho

return
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

--[[
  2018 #
  2026-10-23
]]
