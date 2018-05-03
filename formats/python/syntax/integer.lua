--[[
  integer      ::=  decinteger | bininteger | octinteger | hexinteger
  decinteger   ::=  nonzerodigit (["_"] digit)* | "0"+ (["_"] "0")*
  bininteger   ::=  "0" ("b" | "B") (["_"] bindigit)+
  octinteger   ::=  "0" ("o" | "O") (["_"] octdigit)+
  hexinteger   ::=  "0" ("x" | "X") (["_"] hexdigit)+
  nonzerodigit ::=  "1"..."9"
  digit        ::=  "0"..."9"
  bindigit     ::=  "0" | "1"
  octdigit     ::=  "0"..."7"
  hexdigit     ::=  digit | "a"..."f" | "A"..."F"

  -- https://docs.python.org/3/reference/lexical_analysis.html#literals
]]


local nonzerodigit =
  match_regexp('[1-9]')

local digit =
  match_regexp('[0-9]')

local decinteger =
  cho(
    {
      nonzerodigit,
      opt_rep(
        opt('_'),
        digit
      )
    },
    {
      rep('0'),
      opt_rep(
        opt('_'),
        '0'
      )
    }
  )

local bindigit =
  cho('0', '1')

local bininteger =
  {
    '0',
    cho('b', 'B'),
    rep(
      opt('_'),
      bindigit
    ),
  }

local octdigit =
  match_regexp('[0-7]')

local octinteger =
  {
    '0',
    cho('o', 'O'),
    rep(
      opt('_'),
      octdigit
    ),
  }

local hexdigit =
  match_regexp('[0-9a-fA-F]')

local hexinteger =
  {
    '0',
    cho('x', 'X'),
    rep(
      opt('_'),
      hexdigit
    ),
  }

local integer =
  cho(decinteger, bininteger, octinteger, hexinteger)
