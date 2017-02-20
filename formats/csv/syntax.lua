local parser = request('^.^.mechs.parser')
local handy = parser.handy

local field_sep_char = ','

local opt_spc = handy.match_pattern('[ \t]*')

local quoted_data =
  {
    opt_spc,
    {
      name = 'quoted_data',
      '"',
      handy.opt_rep(
        handy.cho(
          handy.match_pattern('[^"]+'),
          '""'
        )
      ),
      '"',
    },
    opt_spc
  }

local unquoted_data =
  {
    name = 'unquoted_data',
    handy.match_pattern('[^' .. field_sep_char .. '\r\n]*'),
  }

return
  handy.list(
    {
      name = 'record',
      handy.list(
        handy.cho(
          quoted_data,
          unquoted_data
        ),
        {name = 'field_sep', field_sep_char}
      )
    },
    handy.match_pattern('[\r]?\n')
  )
