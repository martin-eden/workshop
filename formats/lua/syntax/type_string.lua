local handy = request('!.mechs.processor.handy')
local match_regexp = request('!.mechs.parser.handy').match_regexp

local opt_rep = handy.opt_rep
local cho = handy.cho

local long_bracket = request('words.particles.long_bracket')

return
  {
    name = 'string',
    cho(
      long_bracket,
      {
        '"',
        opt_rep(
          cho(
            match_regexp([[[^%\%"]+]]),
            match_regexp([[%\.]])
          )
        ),
        '"'
      },
      {
        "'",
        opt_rep(
          cho(
            match_regexp([[[^%\%']+]]),
            match_regexp([[%\.]])
          )
        ),
        "'"
      }
    )
  }
