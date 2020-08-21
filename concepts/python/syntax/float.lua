--[[
  floatnumber   ::=  pointfloat | exponentfloat
  pointfloat    ::=  [digitpart] fraction | digitpart "."
  exponentfloat ::=  (digitpart | pointfloat) exponent
  digitpart     ::=  digit (["_"] digit)*
  fraction      ::=  "." digitpart
  exponent      ::=  ("e" | "E") ["+" | "-"] digitpart

  -- https://docs.python.org/3/reference/lexical_analysis.html#floating-point-literals
]]

local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local cho = handy.cho

local dec_digits = request('dec_digits')

local fix_format =
  cho(
    {opt(dec_digits), '.', dec_digits},
    {dec_digits, '.'}
  )

local exp_part =
  {cho('e', 'E'), opt(cho('+', '-')), dec_digits}

local sci_format =
  {cho(dec_digits, fix_format), exp_part}

local float =
  cho(fix_format, sci_format)

return float
