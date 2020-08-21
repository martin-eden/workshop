local handy = request('!.mechs.processor.handy')
local match_regexp = request('!.mechs.parser.handy').match_regexp
local any_char = request('!.mechs.parser.handy').any_char

local opt = handy.opt
local opt_rep = handy.opt_rep
local rep = handy.rep
local cho = handy.cho
local is_not = handy.is_not

local charset_char =
  cho(
    {name = 'alphabet', 'a'},
    {name = 'non-alphabet', 'A'},
    {name = 'ascii-0..31', 'c'},
    {name = 'non-ascii-0..31', 'C'},
    {name = 'digit-0..9', 'd'},
    {name = 'non-digit-0..9', 'D'},
    {name = 'printable-minus_space', 'g'},
    {name = 'non-printable-plus_space', 'G'},
    {name = 'alphabet-lowercase', 'l'},
    {name = 'non-alphabet-lowercase', 'L'},
    {name = 'punctuation', 'p'},
    {name = 'non-ponctuation', 'P'},
    {name = 'space_chars', 's'},
    {name = 'non-space_chars', 'S'},
    {name = 'alphabet-uppercase', 'u'},
    {name = 'non-alphabet-uppercase', 'U'},
    {name = 'alphabet-plus_digits', 'w'},
    {name = 'non-alphabet-minus_digits', 'W'},
    {name = 'hex_digit-0..f', 'x'},
    {name = 'non-hex_digit-0..f', 'X'}
  )

local charset =
  {'%', charset_char}

local char =
  cho(
    {'%', is_not(charset_char), {name = 'escaped_char', any_char}},
    {is_not('%'), {name = 'char', any_char}}
  )

local set =
  {
    name = 'set',
    '[',
    opt({name = 'is_not', '^'}),
    rep(
      is_not(']'),
      cho(
        charset,
        {name = 'range', {name = 'from', char}, '-', {name = 'to', char}},
        char
      )
    ),
    ']',
  }

local slot =
  cho(
    {name = 'any_char', '.'},
    set,
    charset,
    char
  )

local handle_flag =
  cho(
    {name = 'opt_rep', '*'},
    {name = 'rep', '+'},
    {name = 'min_rep', '-'},
    {name = 'opt', '?'}
  )

local regexp =
  {
    inner_name = 'regexp',
    name = 'regexp',
    opt_rep(
      is_not(')'),
      cho(
        {
          name = 'capture',
          '(', '>regexp', ')',
        },
        {
          '%',
          cho(
            {name = 'capture_ref', match_regexp('%d')},
            {name = 'balanced_brackets', 'b', any_char, any_char},
            {name = 'lookahead_char', 'f', set}
          )
        },
        {slot, opt(handle_flag)}
      )
    )
  }

local link = request('!.mechs.processor.link')
link(regexp)

local optimize = request('!.mechs.processor.optimize')
optimize(regexp)

return regexp
