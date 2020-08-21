--[[
  stringliteral   ::=  [stringprefix](shortstring | longstring)
  stringprefix    ::=  "r" | "u" | "R" | "U" | "f" | "F"
                       | "fr" | "Fr" | "fR" | "FR" | "rf" | "rF" | "Rf" | "RF"
  shortstring     ::=  "'" shortstringitem* "'" | '"' shortstringitem* '"'
  longstring      ::=  "'''" longstringitem* "'''" | '"""' longstringitem* '"""'
  shortstringitem ::=  shortstringchar | stringescapeseq
  longstringitem  ::=  longstringchar | stringescapeseq
  shortstringchar ::=  <any source character except "\" or newline or the quote>
  longstringchar  ::=  <any source character except "\">
  stringescapeseq ::=  "\" <any source character>

  bytesliteral   ::=  bytesprefix(shortbytes | longbytes)
  bytesprefix    ::=  "b" | "B" | "br" | "Br" | "bR" | "BR" | "rb" | "rB" | "Rb" | "RB"
  shortbytes     ::=  "'" shortbytesitem* "'" | '"' shortbytesitem* '"'
  longbytes      ::=  "'''" longbytesitem* "'''" | '"""' longbytesitem* '"""'
  shortbytesitem ::=  shortbyteschar | bytesescapeseq
  longbytesitem  ::=  longbyteschar | bytesescapeseq
  shortbyteschar ::=  <any ASCII character except "\" or newline or the quote>
  longbyteschar  ::=  <any ASCII character except "\">
  bytesescapeseq ::=  "\" <any ASCII character>

  -- https://docs.python.org/3/reference/lexical_analysis.html#grammar-token-stringprefix

  This is fuckingly verbose! For simple parsing I allow any byte in
  "StringEscapeSeq" and in "BytesEscapeSeq". Also this grammar allows
  unescaped newlines in short strings. Verification may be done at
  later stages.
]]

local bytes = cho('b', 'B')
local format = cho('f', 'F')
local unicode = cho('u', 'U')
local raw = cho('r', 'R')

local string_prefix =
  {
    cho(
      {bytes, opt(raw)},
      {raw, opt(bytes)},
      {format, opt(raw)},
      {raw, opt(format)},
      unicode
    )
  }

local short_string =
  {
    cho(
      {
        "'",
        opt_rep(
          cho(
            match_regexp([[[^%\%']+]]),
            match_regexp([[%\.]])
          )
        ),
        "'",
      },
      {
        '"',
        opt_rep(
          cho(
            match_regexp([[[^%\%"]+]]),
            match_regexp([[%\.]])
          )
        ),
        '"',
      }
    )
  }

local long_string =
  {
    cho(
      {
        "'''",
        opt_rep(
          cho(
            {is_not("'''"), "'"},
            match_regexp([=[[^%\]]=]),
            match_regexp([[%\.]])
          )
        ),
        "'''",
      },
      {
        '"""',
        opt_rep(
          cho(
            {is_not('"""'), '"'},
            match_regexp([=[[^%\]]=]),
            match_regexp([[%\.]])
          )
        ),
        '"""',
      }
    )
  }

local string =
  {
    opt(string_prefix),
    cho(short_string, long_string),
  }

return string
