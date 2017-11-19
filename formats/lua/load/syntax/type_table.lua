local handy = request('!.mechs.processor.handy')

local name = request('words.name')
local bracket_expr = request('expressions.bracket_expr')
local syntel = request('words.syntel')

local key_val =
  {
    name = 'key_val',
    handy.opt(
      handy.cho(
        bracket_expr,
        name
      ),
      syntel('=')
    ),
    '>expression',
  }

local rec_sep =
  {
    handy.cho(syntel(','), syntel(';'))
  }

return
  {
    name = 'table',
    syntel('{'),
    handy.opt(
      handy.list(key_val, rec_sep),
      handy.opt(rec_sep)
    ),
    syntel('}'),
  }
